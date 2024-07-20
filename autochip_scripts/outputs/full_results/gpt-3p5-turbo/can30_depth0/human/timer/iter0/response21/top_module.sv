module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
	// internal signal for storing the count value
	reg [9:0] count;

	// internal signal for storing whether the counter is loaded
	reg loaded;

	// always block for counting down and asserting tc
	always @(posedge clk) begin
		if (load) begin
			// load the counter with the data value
			count <= data;
			loaded <= 1;
		end else if (count > 0) begin
			// decrement the counter if it is greater than 0
			count <= count - 1;
			loaded <= 0;
		end
	end

	// assign tc based on the counter value
	assign tc = (count == 0) ? 1'b1 : 1'b0;
endmodule
