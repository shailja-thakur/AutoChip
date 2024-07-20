module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

reg [3:0] shift_reg;
reg [3:0] next_reg;

always @(posedge clk or negedge resetn) begin
	if (~resetn)
		shift_reg <= 4'b0;
	else
		shift_reg <= next_reg;
end

always @(posedge clk) begin
	next_reg[0] <= in;
	next_reg[1] <= shift_reg[0];
	next_reg[2] <= shift_reg[1];
	next_reg[3] <= shift_reg[2];
end

assign out = shift_reg[3];

endmodule
