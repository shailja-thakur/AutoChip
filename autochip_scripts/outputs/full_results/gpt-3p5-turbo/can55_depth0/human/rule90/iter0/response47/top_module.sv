module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	reg [512:0] temp;
	
	// Load input data at the beginning
	always @(posedge clk) begin
		if (load) begin
			temp[511:0] <= data;
		end
	end
	
	// Perform one time step each clock cycle
	always @(posedge clk) begin
		temp[0] <= 0;
		temp[511:1] <= {(temp[510:0] ^ temp[512:2]),0};
		q <= temp[511:0];
	end

endmodule
