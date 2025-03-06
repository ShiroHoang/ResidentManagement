/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author huyng
 */
public class Registration {
    private int registrationId;
    private int userId;
    private String registrationType;
    private String startDate;
    private String endDate;
    private String status;
    private int approveById;
    private String comments;
    private int headOfHouseholdID;
    private String relationship;
    private String headOfHouseholdName;
    private String requestType;

    public int getHeadOfHouseholdID() {
        return headOfHouseholdID;
    }

    public void setHeadOfHouseholdID(int headOfHouseholdID) {
        this.headOfHouseholdID = headOfHouseholdID;
    }

    public String getRelationship() {
        return relationship;
    }

    public void setRelationship(String relationship) {
        this.relationship = relationship;
    }

    public String getHeadOfHouseholdName() {
        return headOfHouseholdName;
    }

    public void setHeadOfHouseholdName(String headOfHouseholdName) {
        this.headOfHouseholdName = headOfHouseholdName;
    }

    public String getRequestType() {
        return requestType;
    }

    public void setRequestType(String requestType) {
        this.requestType = requestType;
    }

    public Registration(int registrationId, int userId, String registrationType, String startDate, String endDate,
            String status, String comments, String relationship, String headOfHouseholdName, String requestType) {
        this.registrationId = registrationId;
        this.userId = userId;
        this.registrationType = registrationType;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
        this.comments = comments;
        this.relationship = relationship;
        this.headOfHouseholdName = headOfHouseholdName;
        this.requestType = requestType;
    }

   

    
    
    public Registration(int registrationId, int userId, String registrationType, String startDate, String status) {
        this.registrationId = registrationId;
        this.userId = userId;
        this.registrationType = registrationType;
        this.startDate = startDate;
        this.status = status;
    }

    public Registration(int registrationId, int userId, String registrationType, String startDate, String endDate, String status, int approveById, String comments) {
        this.registrationId = registrationId;
        this.userId = userId;
        this.registrationType = registrationType;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
        this.approveById = approveById;
        this.comments = comments;
    }

    public int getRegistrationId() {
        return registrationId;
    }

    public void setRegistrationId(int registrationId) {
        this.registrationId = registrationId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getRegistrationType() {
        return registrationType;
    }

    public void setRegistrationType(String registrationType) {
        this.registrationType = registrationType;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getApproveById() {
        return approveById;
    }

    public void setApproveById(int approveById) {
        this.approveById = approveById;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }

    @Override
    public String toString() {
        return "Registration{" + "registrationId=" + registrationId + ", userId=" + userId + ", registrationType=" + registrationType + ", startDate=" + startDate + ", endDate=" + endDate + ", status=" + status + ", approveById=" + approveById + ", comments=" + comments + '}';
    }
    
}
