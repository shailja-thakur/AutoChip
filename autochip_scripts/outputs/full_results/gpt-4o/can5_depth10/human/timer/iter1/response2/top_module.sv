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
			tc <= 0; // Clear tc when new load value is set
		end else begin
			if (counter > 0) begin
				counter <= counter - 1;
				tc <= 0; // Ensure tc is cleared while counting down
			end else begin
				tc <= 1; // Set tc when counter has reached 0
			end
		end
	end

endmodule
