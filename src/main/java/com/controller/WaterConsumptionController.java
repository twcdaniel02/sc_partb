package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.dbUtil.DBConnect;
import com.dbUtil.WaterConDAO;
import com.model.WaterValidation;
import com.utils.SQLContents;
import com.utils.SessionContents;

@Controller
public class WaterConsumptionController {

    @RequestMapping("/waterConsumption")
    protected ModelAndView getWaterConsumptionPage(HttpServletRequest request) throws SQLException {
        HttpSession session = request.getSession();
        int userID = (Integer) session.getAttribute(SessionContents.USER_ID);
        try (Connection conn = DBConnect.openConnection()) {
            LocalDate currentDate = LocalDate.now();
            String sql = SQLContents.SELECT_APPLICATION_BY_USER_AND_DATE;

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, userID);
                stmt.setInt(2, currentDate.getYear());
                stmt.setInt(3, currentDate.getMonthValue());

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        if (rs.getInt(SessionContents.WATER_ID) > 0) {
                            // Water consumption already submitted
                            WaterConDAO waterConDAO = new WaterConDAO();
                            WaterValidation waterCon = waterConDAO.getWaterConDetails(rs.getInt(SessionContents.WATER_ID));
                            ModelAndView model = new ModelAndView("waterConsumption");
                            model.addObject(SessionContents.USER_ID, userID);
                            model.addObject("waterCon", waterCon);
                            return model;
                        } else {
                            // Redirect to submission form
                            ModelAndView model = new ModelAndView(new RedirectView(SessionContents.WATER_CONSUMPTION_FORM_VIEW));
                            model.setViewName(SessionContents.REDIRECT_WATER_CONSUMPTION_FORM);
                            return model;
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        ModelAndView model = new ModelAndView(new RedirectView(SessionContents.WATER_CONSUMPTION_FORM_VIEW));
        model.setViewName(SessionContents.REDIRECT_WATER_CONSUMPTION_FORM);
        return model;
    }

    @RequestMapping("/waterConsumptionForm")
    protected ModelAndView getWaterConsumptionFormPage(HttpServletRequest request) {
        ModelAndView model = new ModelAndView(SessionContents.WATER_CONSUMPTION_FORM_VIEW);
        HttpSession session = request.getSession();
        model.addObject(SessionContents.USER_ID, (Integer) session.getAttribute(SessionContents.USER_ID));
        return model;
    }

    @RequestMapping("/waterConsumptionEdit")
    protected ModelAndView getWaterConsumptionEditPage(HttpServletRequest request) {
        HttpSession session = request.getSession();
        int userID = (Integer) session.getAttribute(SessionContents.USER_ID);

        try (Connection conn = DBConnect.openConnection()) {
            LocalDate currentDate = LocalDate.now();
            String sql = SQLContents.SELECT_APPLICATION_BY_USER_AND_DATE;

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, userID);
                stmt.setInt(2, currentDate.getYear());
                stmt.setInt(3, currentDate.getMonthValue());

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        if (rs.getInt(SessionContents.WATER_ID) > 0) {
                            // Water consumption already submitted
                            WaterConDAO waterConDAO = new WaterConDAO();
                            WaterValidation waterCon = waterConDAO.getWaterConDetails(rs.getInt(SessionContents.WATER_ID));
                            ModelAndView model = new ModelAndView("waterConsumptionEdit");
                            model.addObject(SessionContents.USER_ID, userID);
                            model.addObject("waterCon", waterCon);
                            return model;
                        } else {
                            // Redirect to submission form
                            ModelAndView model = new ModelAndView(new RedirectView(SessionContents.WATER_CONSUMPTION_FORM_VIEW));
                            model.setViewName(SessionContents.REDIRECT_WATER_CONSUMPTION_FORM);
                            return model;
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        ModelAndView model = new ModelAndView(new RedirectView(SessionContents.WATER_CONSUMPTION_FORM_VIEW));
        model.setViewName(SessionContents.REDIRECT_WATER_CONSUMPTION_FORM);
        return model;
    }

    @RequestMapping("/waterSubmit")
    protected ModelAndView getWaterSubmitPage(HttpServletRequest request,
            @RequestParam("proportionalFactor") float proportionalFactor,
            @RequestParam("waterUsageRM") float waterUsageRM,
            @RequestParam("waterUsageM3") float waterUsageM3, @RequestParam MultipartFile billImage)
            throws SQLException, IOException {

        HttpSession session = request.getSession();
        int userID = (Integer) session.getAttribute(SessionContents.USER_ID);
        Connection conn = DBConnect.openConnection();
        LocalDate currentDate = LocalDate.now();
        String applicationSql = SQLContents.SELECT_APPLICATION_BY_USER_AND_DATE;
        PreparedStatement stmt = conn.prepareStatement(applicationSql);
        stmt.setInt(1, userID);
        stmt.setInt(2, currentDate.getYear());
        stmt.setInt(3, currentDate.getMonthValue());

        byte[] fileBytes = null;
        if (!billImage.isEmpty()) {
            fileBytes = billImage.getBytes();
        }

        String message = null;

        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                if (rs.getInt(SessionContents.WATER_ID) > 0) {
                    // Update water consumption
                    WaterConDAO waterConDAO = new WaterConDAO();
                    if (fileBytes != null) {
                        waterConDAO.updateWaterCon(proportionalFactor, waterUsageRM, waterUsageM3, fileBytes,
                                rs.getInt(SessionContents.WATER_ID));
                        message = "Update successfully";
                    } else {
                        waterConDAO.updateWaterConNoProof(proportionalFactor, waterUsageRM, waterUsageM3,
                                rs.getInt(SessionContents.WATER_ID));
                        message = "Update successfully";
                    }
                } else {
                    // Insert water consumption
                    WaterConDAO waterConDAO = new WaterConDAO();
                    waterConDAO.insertWaterConAndUpdateApplication(proportionalFactor, waterUsageRM, waterUsageM3,
                            fileBytes, rs.getInt("applicationID"));
                    message = "Submit successfully";
                }
            } else {
                // Create water consumption
                WaterConDAO waterConDAO = new WaterConDAO();
                waterConDAO.insertWaterConAndCreateApplication(proportionalFactor, waterUsageRM, waterUsageM3,
                        fileBytes, userID, currentDate);
                message = "Submit successfully";
            }
        }

        ModelAndView model = new ModelAndView("waterSubmitResponse");
        model.addObject("message", message);
        return model;
    }
}
