module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [3:0] state;
reg [3:0] prev_state;

parameter ABOVE_S3 = 4'b1110;
parameter BETWEEN_S3_AND_S2 = 4'b1100;
parameter BETWEEN_S2_AND_S1 = 4'b1000;
parameter BELOW_S1 = 4'b0000;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= BELOW_S1;
        prev_state <= BELOW_S1;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
    end else begin
        case (state)
            ABOVE_S3:
                begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                    if (s[3] == 1'b0) begin
                        state <= BETWEEN_S3_AND_S2;
                    end
                end
            BETWEEN_S3_AND_S2:
                begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b0;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                    if (s[2] == 1'b0) begin
                        state <= BETWEEN_S2_AND_S1;
                    end else if (s[3] == 1'b1) begin
                        state <= ABOVE_S3;
                    end
                end
            BETWEEN_S2_AND_S1:
                begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b0;
                    dfr <= 1'b0;
                    if (s[1] == 1'b0) begin
                        state <= BELOW_S1;
                    end else if (s[2] == 1'b1) begin
                        state <= BETWEEN_S3_AND_S2;
                    end
                end
            BELOW_S1:
                begin
                    fr3 <= 1'b1;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                    if (s[1] == 1'b1) begin
                        state <= BETWEEN_S2_AND_S1;
                    end
                end
        endcase
    end
end

always @(posedge clk) begin
    prev_state <= state;
end

endmodule
