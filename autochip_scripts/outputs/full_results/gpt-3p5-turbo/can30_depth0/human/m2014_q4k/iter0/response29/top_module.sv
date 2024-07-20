module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
// shift register with four D flops
reg [3:0] shift_reg;
reg out;

always @(posedge clk or negedge resetn) begin
	if (!resetn) begin
		shift_reg <= 4'b0; // reset to 0
		out <= 1'b0; // reset to 0
	end
	else begin
		shift_reg <= {shift_reg[2:0], in}; // shift the data in
		out <= shift_reg[3]; // output the last bit
	end
end

endmodule
