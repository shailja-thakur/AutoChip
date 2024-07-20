module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);
	reg [9:0] counter; // 10-bit counter

	always @(posedge clk) begin
		if (load == 1) begin // load counter with data
			counter <= data;
		end else if (counter > 0) begin // decrement counter by 1
			counter <= counter - 1;
		end
	end

	assign tc = (counter == 0); // assert tc when counter reaches 0
endmodule
