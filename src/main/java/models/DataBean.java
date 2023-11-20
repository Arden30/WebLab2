package models;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class DataBean implements Serializable {
    private final List<ClientData> data;

    public DataBean() {
        data  = new ArrayList<>();
    }

    public List<ClientData> getData() {
        return data;
    }

    public void setData(ClientData clientData) {
        data.add(clientData);
    }
}
