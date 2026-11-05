package model;

public class FunnelData {

    private int userId;
    private String stage;
    private String device;
    private String source;

    // ─── Constructors ───────────────────────────────────────────────────────────

    public FunnelData() {}

    public FunnelData(int userId, String stage, String device, String source) {
        this.userId = userId;
        this.stage  = stage;
        this.device = device;
        this.source = source;
    }

    // ─── Getters ────────────────────────────────────────────────────────────────

    public int getUserId()     { return userId; }
    public String getStage()   { return stage;  }
    public String getDevice()  { return device; }
    public String getSource()  { return source; }

    // ─── Setters ────────────────────────────────────────────────────────────────

    public void setUserId(int userId)      { this.userId = userId; }
    public void setStage(String stage)     { this.stage  = stage;  }
    public void setDevice(String device)   { this.device = device; }
    public void setSource(String source)   { this.source = source; }

    // ─── toString (useful for debugging) ────────────────────────────────────────

    @Override
    public String toString() {
        return "FunnelData{" +
               "userId="  + userId  +
               ", stage='"  + stage  + '\'' +
               ", device='" + device + '\'' +
               ", source='" + source + '\'' +
               '}';
    }
}
