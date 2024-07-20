module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);
	
	reg [3:0] state;
	assign start_shifting = (state == 4'b1101);
	
	always @(posedge clk) begin
		if (reset)
			state <= 4'b0000;
		else begin
			case (state)
				4'b0000: if (data) state <= 4'b0001; else state <= 4'b0000;
				4'b0001: if (data) state <= 4'b0011; else state <= 4'b0000;
				4'b0011: if (data) state <= 4'b0011; else state <= 4'b0110;
				4'b0110: if (data) state <= 4'b1101; else state <= 4'b0000;
				default: state <= state;
			endcase
		end
	end
endmodule
