module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [3:1] s_reg;
reg [3:1] s_reg_prev;
reg [2:0] level;

always @(posedge clk or posedge reset) begin
    if (reset) begin // synchronous reset
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b1;
        s_reg <= 3'b0;
        s_reg_prev <= 3'b0;
        level <= 3'b0;
    end else begin
        s_reg_prev <= s_reg;
        s_reg <= s;

        case (s_reg)
            3'b000: begin // Below s[1]
                level <= 3'b0;
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b0;
            end
            3'b001: begin // Between s[2] and s[1]
                level <= 3'b1;
                if (s_reg_prev == 3'b011) begin // check if previous level is lower
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b1; // open Supplemental flow valve
                end else begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b1;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end
            end
            3'b011: begin // Between s[3] and s[2]
                level <= 3'b2;
                if (s_reg_prev == 3'b001) begin // check if previous level is lower
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= 1'b1; // open Supplemental flow valve
                end else begin
                    fr3 <= 1'b0;
                    fr2 <= 1'b0;
                    fr1 <= 1'b1;
                    dfr <= 1'b0;
                end
            end
            3'b111: begin // Above s[3]
                level <= 3'b3;
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
        endcase
    end
end

endmodule
