module top_module(
	input clk,
	input areset,
	input load,
	input ena,
	input [3:0] data,
	output reg [3:0] q);

	// Internal signals
	reg [3:0] q_temp;
	
	always @(posedge clk) begin
		if (areset) begin
			// Reset shift register
			q_temp <= 4'b0000;
		end else if (load) begin
			// Load data into shift register
			q_temp <= data;
		end else if (ena) begin
			// Shift right
			q_temp <= {q_temp[2:0], 1'b0};
		end
	end
	
	// Assign q_temp to q
	always @(posedge clk) begin
		q <= q_temp;
	end

endmodule
