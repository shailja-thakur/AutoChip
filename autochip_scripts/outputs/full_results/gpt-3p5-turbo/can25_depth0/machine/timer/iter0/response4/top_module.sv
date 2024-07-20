module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);

	reg [9:0] counter;

	always @(posedge clk) begin
		if (load == 1'b1) begin // load counter
			counter <= data;
		end else begin // decrement counter
			if (counter != 0) begin
				counter <= counter - 1;
			end
		end
	end

	assign tc = (counter == 0) ? 1'b1 : 1'b0;

endmodule
