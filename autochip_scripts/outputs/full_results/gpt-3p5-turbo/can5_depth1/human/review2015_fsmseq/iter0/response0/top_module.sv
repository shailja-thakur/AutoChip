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
			case (state)
				0: if (data == 1) state <= 1;
				1: if (data == 1) state <= 2; else state <= 0;
				2: if (data == 0) state <= 3; else if (data == 1) state <= 2; else state <= 0;
				3: if (data == 1) start_shifting <= 1; state <= 4;
				4: if (data == 1) state <= 2; else state <= 0;
				default: state <= 0;
			endcase
		end
	end

endmodule
