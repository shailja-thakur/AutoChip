module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output reg tc
);

reg [9:0] counter;

always @(posedge clk) begin
	if (load) begin
		counter <= data;
		tc <= 0;    // Reset terminal count when loading new data.
	end else begin
		if (counter > 0) begin
			counter <= counter - 1;
			tc <= 0;
		end else begin
			tc <= 1;  // Assert terminal count signal when counter is 0.
		end
	end
end

endmodule
