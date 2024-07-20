module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	reg [3:0] next_state;
	
	always @(posedge clk) begin
		if (reset) begin
			state <= 4'b0000;
			start_shifting <= 0;
		end else begin
			state <= next_state;
			if (state == 4'b1100 && data) begin
				start_shifting <= 1;
			end else begin
				start_shifting <= 0;
			end
		end
	end
	
	always @(state, data) begin
		case (state)
			4'b0000: next_state = (data == 1) ? 4'b0001 : 4'b0000;
			4'b0001: next_state = (data == 1) ? 4'b0010 : 4'b0000;
			4'b0010: next_state = (data == 1) ? 4'b0011 : 4'b0000;
			4'b0011: next_state = (data == 1) ? 4'b1100 : 4'b0000;
			default: next_state = 4'b0000;
		endcase
	end

endmodule
