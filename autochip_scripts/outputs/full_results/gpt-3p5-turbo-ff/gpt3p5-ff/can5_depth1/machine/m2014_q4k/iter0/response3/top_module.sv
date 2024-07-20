module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	reg [3:0] sr;  // 4-bit register to store data
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			sr <= 4'b0;  // Reset the register to all zeros
		end else begin
			sr <= {sr[2:0], in};  // Shift left and load input into least significant bit
		end
	end
	
	assign out = sr[3];  // Output is the most significant bit of the register
endmodule
