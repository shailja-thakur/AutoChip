module top_module(
	input clk,
	input areset,
	input load,
	input ena,
	input [3:0] data,
	output reg [3:0] q);

	reg [3:0] q_temp;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			q_temp <= 4'b0;
		end else if (load) begin
			q_temp <= data;
		end else if (ena) begin
			q_temp <= {q_temp[2:0], 1'b0};
		end
	end

	// Priority encoder for load and ena
	always @(load, ena) begin
		if (load && ena) begin
			q <= data;
		end else begin
			q <= q_temp;
		end
	end
endmodule
