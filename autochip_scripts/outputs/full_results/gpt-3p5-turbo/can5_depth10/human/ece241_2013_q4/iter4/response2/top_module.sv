module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [2:0] prev_s;

always @(posedge clk) begin
    if (reset) begin
        prev_s <= 3'b000;
        fr3 <= 1'b1;
        fr2 <= 1'b1;
        fr1 <= 1'b1;
        dfr <= 1'b0;
    end else begin
        prev_s <= s;

        case ({s, prev_s})
            2'b10_1: begin // Above s[3]
                fr3 <= 1'b0;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
            2'b01_1: begin // Between s[3] and s[2]
                fr3 <= 1'b1;
                fr2 <= 1'b0;
                fr1 <= 1'b0;
                dfr <= 1'b0;
            end
            2'b00_1: begin // Between s[2] and s[1]
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b0;

                if (s[2] < prev_s[2]) begin
                    dfr <= 1'b1;
                end else begin
                    dfr <= 1'b0;
                end
            end
            2'b00_0: begin // Below s[1]
                fr3 <= 1'b1;
                fr2 <= 1'b1;
                fr1 <= 1'b1;
                dfr <= 1'b1;
            end
            default: begin
                fr3 <= fr3;
                fr2 <= fr2;
                fr1 <= fr1;
                dfr <= dfr;
            end
        endcase
    end
end

endmodule
