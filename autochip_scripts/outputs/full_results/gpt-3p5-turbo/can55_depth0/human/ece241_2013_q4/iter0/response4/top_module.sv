module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [3:1] prev_s;
integer water_level;

always @(posedge clk) begin
    if (reset) begin
        prev_s <= 3'b000;
        water_level <= 0;
        fr3 <= 0;
        fr2 <= 0;
        fr1 <= 0;
        dfr <= 0;
    end else begin
        prev_s <= s;
        case (prev_s)
            3'b111: begin // Above s[3]
                fr3 <= 0;
                fr2 <= 0;
                fr1 <= 0;
                dfr <= 0;
                water_level <= 3;
            end
            3'b110: begin // Between s[3] and s[2]
                fr3 <= 0;
                fr2 <= 0;
                fr1 <= 1;
                dfr <= 0;
                water_level <= 2;
            end
            3'b100: begin // Between s[2] and s[1]
                fr3 <= 0;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= 0;
                water_level <= 1;
            end
            default: begin // Below s[1]
                fr3 <= 1;
                fr2 <= 1;
                fr1 <= 1;
                dfr <= 0;
                water_level <= 0;
            end
        endcase
    end
end

endmodule
