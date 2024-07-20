module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);

	reg [15:0] q_reg; // Register to store the previous value of q
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			q_reg <= 16'b0; // Reset the register to all zeros
		else begin
			if (byteena[0])
				q_reg[7:0] <= d[7:0]; // Update lower byte if byteena[0] is high
			if (byteena[1])
				q_reg[15:8] <= d[15:8]; // Update upper byte if byteena[1] is high
		end
	end
	
	always @(*) begin
		q = q_reg; // Output the stored value of q
	end

endmodule
