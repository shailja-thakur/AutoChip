module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);

	// Sequential logic - triggered on the rising edge of clock or the negative edge of reset
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			q <= 16'b0;  // Reset register to 0
		end
		else begin
			// Write data to the register based on byte enable signals
			if (byteena[0]) begin
				q[7:0] <= d[7:0];  // Write lower 8 bits
			end
			if (byteena[1]) begin
				q[15:8] <= d[15:8];  // Write upper 8 bits
			end
		end
	end
endmodule
