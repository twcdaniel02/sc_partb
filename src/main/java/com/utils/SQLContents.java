package com.utils;

public class SQLContents {

    private SQLContents() {
        // Prevent instantiation
    }

    public static final String SELECT_APPLICATION_BY_USER_AND_DATE =
        "SELECT * FROM application WHERE userID = ? AND DATE_FORMAT(date, '%Y') = ? AND DATE_FORMAT(date, '%m') = ?";
        
    public static final String QUERY_SELECT_USER_BY_EMAIL = 
        "SELECT * FROM users WHERE email=?";
}

