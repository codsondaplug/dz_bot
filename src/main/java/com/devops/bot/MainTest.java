package com.devops.bot;

public class MainTest {

    public static void main(String[] args) {
        testAdd();
        testGreetThrowsOnEmpty();
        System.out.println("Все тесты пройдены успешно!");
    }

    // Тест: проверка сложения двух чисел
    static void testAdd() {
        int result = Main.add(2, 3);
        if (result != 5) {
            throw new AssertionError("Ожидалось 5, но получено: " + result);
        }
        System.out.println("testAdd: ПРОЙДЕН");
    }

    // Тест: проверка что метод greet выбрасывает исключение при пустом имени
    static void testGreetThrowsOnEmpty() {
        try {
            Main.greet("");
            throw new AssertionError("Ожидалось исключение, но оно не было выброшено");
        } catch (IllegalArgumentException e) {
            System.out.println("testGreetThrowsOnEmpty: ПРОЙДЕН");
        }
    }
}
