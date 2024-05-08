module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);

	reg [9:0] counter;
	reg [1:0] state;

	always @(posedge clk) begin
		if (load) begin
			counter <= data;
			state <= 0;
		end else begin
			if (state == 0) begin
				counter <= counter - 1;
				if (counter == 0) begin
					state <= 1;
					tc <= 1;
				end
			end else begin
				state <= 0;
			end
		end
	end

endmodule