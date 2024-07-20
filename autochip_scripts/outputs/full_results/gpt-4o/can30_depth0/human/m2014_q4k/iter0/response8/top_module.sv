module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

reg [3:0] shift_reg;

always @(posedge clk) begin
	if (!resetn) begin
		shift_reg <= 4'b0; // Synchronous reset when resetn is low
	end
	else begin
		shift_reg <= {shift_reg[2:0], in}; // Shift right and load input
	end
end

assign out = shift_reg[3]; // Output the MSB

endmodule
