module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);
	reg [1:0] state;


	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 0;
		else begin
			case (state)
				0: begin
					if (j)
						state <= 1;
				end
				1: begin
					if (k)
						state <= 0;
				end
			endcase
		end
	end


	always @(state) begin
		if (state == 1)
			out <= 1;
		else
			out <= 0;
	end
endmodule
