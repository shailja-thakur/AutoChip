module top_module(
	input clk,
	input areset,
	input load,
	input ena,
	input [3:0] data,
	output reg [3:0] q);

	// Internal signals
	reg [3:0] q_temp; // Temporary register for data input

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			q <= 4'b0000; // Reset shift register to zero
		end else begin
			// Load input has higher priority
			if (load) begin
				q <= data; // Load shift register with data input
			end else begin
				if (ena) begin
					q_temp[3] <= 1'b0; // Shift right, q[3] becomes zero
					q_temp[2:0] <= q[3:1]; // Shift q[0:2] to q[1:3]
					q <= q_temp; // Update shift register
				end
			end
		end
	end

endmodule
