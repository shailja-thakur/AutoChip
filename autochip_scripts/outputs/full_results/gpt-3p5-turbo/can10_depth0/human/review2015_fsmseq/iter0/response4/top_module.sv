module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [3:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 4'b0000;
		end else begin
			case (state)
				4'b0000: if (data == 1'b1) state <= 4'b0001; else state <= 4'b0000;
				4'b0001: if (data == 1'b1) state <= 4'b0010; else state <= 4'b0000;
				4'b0010: if (data == 1'b0) state <= 4'b0011; else state <= 4'b0000;
				4'b0011: if (data == 1'b1) begin
								state <= 4'b0100;
								start_shifting <= 1'b1;
						   end else state <= 4'b0000;
				4'b0100: state <= 4'b0100;
				default: state <= 4'b0000;
			endcase
		end
	end

endmodule
