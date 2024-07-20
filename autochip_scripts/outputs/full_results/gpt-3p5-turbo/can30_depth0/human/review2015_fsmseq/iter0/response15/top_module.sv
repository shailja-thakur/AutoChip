module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 0;
		else begin
			case(state)
				0: if (data) state <= 1;
				1: if (data) state <= 2; else state <= 0;
				2: if (!data) state <= 0; else state <= 3;
				3: if (data) begin 
						state <= 1;
						start_shifting <= 1;
				   end
				   else state <= 0;
			endcase
		end
	end

	always @(posedge clk) begin
		if (reset) 
			start_shifting <= 0;
	end

endmodule
