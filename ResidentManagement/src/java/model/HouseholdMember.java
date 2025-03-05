/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author huyng
 */
public class HouseholdMember { //comment gi day
    private int memberId;
    private int householdId;
    private int userId;
    private String relationship;
    private String typeStay;

    public HouseholdMember(int memberId, int householdId, int userId, String relationship, String typeStay) {
        this.memberId = memberId;
        this.householdId = householdId;
        this.userId = userId;
        this.relationship = relationship;
        this.typeStay = typeStay;
    }

    public HouseholdMember(int householdId, int userId, String relationship, String typeStay) {
        this.householdId = householdId;
        this.userId = userId;
        this.relationship = relationship;
        this.typeStay = typeStay;
    }

    public int getMemberId() {
        return memberId;
    }

    public void setMemberId(int memberId) {
        this.memberId = memberId;
    }

    public int getHouseholdId() {
        return householdId;
    }

    public void setHouseholdId(int householdId) {
        this.householdId = householdId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getRelationship() {
        return relationship;
    }

    public void setRelationship(String relationship) {
        this.relationship = relationship;
    }

    public String getTypeStay() {
        return typeStay;
    }

    public void setTypeStay(String typeStay) {
        this.typeStay = typeStay;
    }
    
}
