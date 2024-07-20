module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

reg [1:0] level;
reg [1:0] prev_level;

always @(posedge clk or posedge reset) begin
    if (reset)
        level <= 2'b00;
    else begin
        prev_level <= level;
        case (s)
            3'b111: level <= 2'b11;
            3'b011: level <= 2'b10;
            3'b001: level <= 2'b01;
            default: level <= 2'b00;
        endcase
    end
end

always @(level or prev_level) begin
    fr3 <= (level == 2'b00) ? 1'b1 : 1'b0;
    fr2 <= ((level == 2'b00) || (level == 2'b01)) ? 1'b1 : 1'b0;
    fr1 <= ((level == 2'b00) || (level == 2'b10) || (level == 2'b01)) ? 1'b1 : 1'b0;
    dfr <= (prev_level < level) ? 1'b1 : 1'b0;
end

endmodule
