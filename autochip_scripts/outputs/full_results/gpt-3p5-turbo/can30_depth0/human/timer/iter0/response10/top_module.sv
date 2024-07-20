module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);

reg [9:0] counter;
reg tc;

// Load counter if load is high
always @(posedge clk) begin
	if (load) begin
		counter <= data;
	end else begin
		// Decrement counter if it is non-zero
		if (counter != 0) begin
			counter <= counter - 1;
		end
	end
end

// Assert tc when counter reaches 0
always @(posedge clk) begin
	if (counter == 0) begin
		tc <= 1;
	end else begin
		tc <= 0;
	end
end

endmodule
