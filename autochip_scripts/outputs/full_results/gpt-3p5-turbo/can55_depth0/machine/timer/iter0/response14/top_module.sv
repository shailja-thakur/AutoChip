module top_module(
	input wire clk, 
	input wire load, 
	input wire [9:0] data, 
	output wire tc
);
	// declare counter variable
	reg [9:0] counter;

	// always block triggered on rising edge of clk
	always @(posedge clk) begin
		// check if load is asserted
		if (load) begin
			// load counter with data value
			counter <= data;
		end else begin
			// check if counter is not 0
			if (counter != 0) begin
				// decrement counter by 1
				counter <= counter - 1;
			end
		end
	end

	// assign tc based on counter value
	assign tc = (counter == 0);

endmodule
