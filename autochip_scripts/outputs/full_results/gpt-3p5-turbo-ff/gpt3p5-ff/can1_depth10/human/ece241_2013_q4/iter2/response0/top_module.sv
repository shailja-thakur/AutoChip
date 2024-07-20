module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [1:0] state;
reg [3:1] prev_s;

// Water Level States
parameter ABOVE_S3 = 2'b00;
parameter BETWEEN_S3_S2 = 2'b01;
parameter BETWEEN_S2_S1 = 2'b10;
parameter BELOW_S1 = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= ABOVE_S3;  // Reset to state equivalent to low water level
    end else begin
        case (state)
            ABOVE_S3:
                if (s[3]) begin
                    state <= BETWEEN_S3_S2;
                end
            BETWEEN_S3_S2:
                if (!s[3] && s[2]) begin
                    state <= BETWEEN_S2_S1;
                end
                if (!s[2]) begin
                    state <= ABOVE_S3;
                end
            BETWEEN_S2_S1:
                if (!s[2] && s[1]) begin
                    state <= BELOW_S1;
                end
                if (!s[1]) begin
                    state <= BETWEEN_S3_S2;
                end
            BELOW_S1:
                if (!s[1] && !s[2]) begin
                    state <= ABOVE_S3;
                end
        endcase
    end
end

always @(posedge clk) begin
    if (reset) begin
        fr3 <= 1'b1;  // Reset all flow rates
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end else begin
        case (state)
            ABOVE_S3:
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            BETWEEN_S3_S2:
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            BETWEEN_S2_S1:
                fr3 <= 1'b0;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            BELOW_S1:
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
        endcase
    end
end

endmodule
