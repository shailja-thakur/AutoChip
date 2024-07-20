module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);

	// Sequential logic for the register
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			q <= 16'b0; // Reset register to 0
		end
		else begin
			// Write data based on byte enable signals
			if (byteena[0])
				q[7:0] <= d[7:0];   // Write lower 8 bits
			if (byteena[1])
				q[15:8] <= d[15:8]; // Write upper 8 bits
		end
	end

endmodule
