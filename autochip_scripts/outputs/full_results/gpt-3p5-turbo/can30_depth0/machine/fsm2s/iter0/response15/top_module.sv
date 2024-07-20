module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	reg [1:0] state;
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= 2'b00;
		else if (state == 2'b00)
		begin
			if (j)
				state <= 2'b01;
			else
				state <= 2'b00;
		end
		else if (state == 2'b01)
		begin
			if (k)
				state <= 2'b00;
			else
				state <= 2'b01;
		end
	end
	
	always @(state)
	begin
		if (state == 2'b01)
			out <= 1'b1;
		else
			out <= 1'b0;
	end

endmodule
