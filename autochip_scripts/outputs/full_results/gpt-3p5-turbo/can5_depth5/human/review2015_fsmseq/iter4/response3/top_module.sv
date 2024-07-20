module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;
	reg [3:0] next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 4'b0000;
			start_shifting <= 0;
		end
		else begin
			state <= next_state;
		end
	end
	
	always @(state or data) begin
		case(state)
			4'b0000: if (data) next_state <= 4'b0001;
			4'b0001: if (data) next_state <= 4'b0010;
			4'b0010: if (data) next_state <= 4'b0011;
			4'b0011: begin
					if (data) begin
						next_state <= 4'b0100;
						start_shifting <= 1;
					end
					else
						next_state <= 4'b0000;
				end
			4'b0100: next_state <= 4'b0000;
			default: next_state <= 4'b0000;
		endcase
	end
endmodule
