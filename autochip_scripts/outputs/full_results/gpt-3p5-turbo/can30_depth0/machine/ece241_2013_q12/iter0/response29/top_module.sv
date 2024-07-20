module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg [7:0] q,
	output reg Z
);

reg [7:0] shift_reg;
wire [2:0] addr;
assign addr = {A, B, C};

always @(posedge clk) begin
	if (enable)
		shift_reg <= shift_reg << 1;
	if (S)
		shift_reg <= shift_reg | 1;
end

always @(addr, shift_reg) begin
	Z <= shift_reg[addr];
end

endmodule
