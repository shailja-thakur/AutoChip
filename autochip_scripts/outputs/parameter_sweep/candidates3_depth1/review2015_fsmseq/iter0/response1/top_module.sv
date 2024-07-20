module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [3:0] state;

	always @(posedge clk or posedge reset)
		if (reset)
			state <= 4'b0000;
		else
			case (state)
				4'b0000: if (data) state <= 4'b0001; else state <= 4'b0000;
				4'b0001: if (data) state <= 4'b0010; else state <= 4'b0000;
				4'b0010: if (data) state <= 4'b0011; else state <= 4'b0000;
				4'b0011: if (data) state <= 4'b0001; else state <= 4'b1100;
				4'b1100: if (data) state <= 4'b0010; else state <= 4'b0000;
			endcase

	assign start_shifting = (state == 4'b0011);
endmodule
