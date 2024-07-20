module top_module (
	input [3:0] in,
	output reg [1:0] pos
);

always @(*) begin
    casez (in)
        4'b1000: pos = 2'b11; // If bit[3] is high, output 3
        4'b?100: pos = 2'b10; // If bit[2] is high, output 2
        4'b??10: pos = 2'b01; // If bit[1] is high, output 1
        4'b???1: pos = 2'b00; // If bit[0] is high, output 0
        default: pos = 2'b00; // If none of the bits are high, output 0
    endcase
end

endmodule
