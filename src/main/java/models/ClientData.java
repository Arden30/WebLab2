package models;

import java.io.Serializable;

public record ClientData(double x,
        double y,
        double r,
        String time,
        long runningTime,
        boolean result) implements Serializable {
}
