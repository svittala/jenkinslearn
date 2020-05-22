<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Large_Requirement</fullName>
        <description>Set Scope High</description>
        <field>Scope__c</field>
        <literalValue>Out-of-Scope (deferred)</literalValue>
        <name>Large Requirement</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Set OutofScope</fullName>
        <actions>
            <name>Large_Requirement</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SunSky_Requirement__c.Capability__c</field>
            <operation>greaterThan</operation>
            <value>100</value>
        </criteriaItems>
        <criteriaItems>
            <field>SunSky_Requirement__c.Scope__c</field>
            <operation>notContain</operation>
            <value>Out-of-Scope (deferred),In-Scope (Manual),Deleted</value>
        </criteriaItems>
        <description>set out of scope for large requirements V11</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
