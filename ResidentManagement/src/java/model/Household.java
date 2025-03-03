/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author huyng
 */
public class Household {
    private int householdId;
    private int headOfHouseholdId;
    private int addressId;
    private String createdDate;

    public Household(int headOfHouseholdId, int addressId, String createdDate) {
        this.headOfHouseholdId = headOfHouseholdId;
        this.addressId = addressId;
        this.createdDate = createdDate;
    }

    public Household(int householdId, int headOfHouseholdId, int addressId, String createdDate) {
        this.householdId = householdId;
        this.headOfHouseholdId = headOfHouseholdId;
        this.addressId = addressId;
        this.createdDate = createdDate;
    }

    public int getHouseholdId() {
        return householdId;
    }

    public void setHouseholdId(int householdId) {
        this.householdId = householdId;
    }

    public int getHeadOfHouseholdId() {
        return headOfHouseholdId;
    }

    public void setHeadOfHouseholdId(int headOfHouseholdId) {
        this.headOfHouseholdId = headOfHouseholdId;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public String getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }
    
    
}
