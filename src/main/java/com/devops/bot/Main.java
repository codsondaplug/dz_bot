package com.devops.bot;

public class Main {

    public static void greet(String name) {
        if (name == null || name.isEmpty()) {
            throw new IllegalArgumentException("Введите имя");
        }
        System.out.println("Привет, " + name + "!");
    }

    public static int add(int a, int b) {
        return a + b;
    }

    public static void main(String[] args) {
        greet("DevOps");
        System.out.println("2 + 3 = " + add(2, 3));
        System.out.println("Работает!");
    }
}

