module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);

	reg [9:0] counter = 0;
	reg [1:0] state = 0;

	always @(posedge clk) begin
		if (load) begin
			counter <= data;
			state <= 1;
		end else begin
			if (state == 1) begin
				counter <= counter - 1;
				if (counter == 0) begin
					state <= 2;
				end
			end else if (state == 2) begin
				tc <= 1;
				state <= 0;
			end
		end
	end

endmodule