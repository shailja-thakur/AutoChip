module top_module(
	input clk,
	input load,
	input [255:0] data,
	output reg [255:0] q);
   
	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			reg [255:0] q_temp; // Declare q_temp inside else block and update value

			q_temp <= q; // Assign value to q_temp

			for (integer i = 0; i < 256; i = i + 1) begin
				integer sum = 0;
				
				// Check neighbors...
				
				// Update cell state...
				
				// Rest of the code...
			end
		end
	end

endmodule
