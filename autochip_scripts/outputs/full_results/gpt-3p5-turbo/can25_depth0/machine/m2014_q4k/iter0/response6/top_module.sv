module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	reg [3:0] sr;  // 4-bit register to store data

	always @(posedge clk) begin
		if (resetn == 0) begin
			sr <= 4'b0;  // Reset register to all zeros
		else begin
			sr <= {sr[2:0], in};  // Shift left by one and load input into LSB
		end
	end

	assign out = sr[3];  // Output is MSB of register

endmodule
