package com.devops.bot;

public class MainTest {

    public static void main(String[] args) {
        testAdd();
        testGreetThrowsOnEmpty();
        System.out.println("All tests passed!");
    }

    static void testAdd() {
        int result = Main.add(2, 3);
        if (result != 5) {
            throw new AssertionError("Expected 5 but got " + result);
        }
        System.out.println("testAdd: PASSED");
    }

    static void testGreetThrowsOnEmpty() {
        try {
            Main.greet("");
            throw new AssertionError("Expected exception not thrown");
        } catch (IllegalArgumentException e) {
            System.out.println("testGreetThrowsOnEmpty: PASSED");
        }
    }
}
