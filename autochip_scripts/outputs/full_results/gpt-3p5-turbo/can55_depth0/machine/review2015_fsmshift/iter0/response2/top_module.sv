module top_module(
	input clk,
	input reset,
	output reg shift_ena,
	output reg [2:0] state);
	
	always @(posedge clk) begin
		if (reset) begin
			state <= 3'b0;
			shift_ena <= 1'b1;
		end else begin
			case(state)
				0: begin
					state <= 3'b1;
					shift_ena <= 1'b1;
				end
				1: begin
					state <= 3'b10;
					shift_ena <= 1'b1;
				end
				2: begin
					state <= 3'b11;
					shift_ena <= 1'b1;
				end
				3: begin
					state <= 3'b100;
					shift_ena <= 1'b1;
				end
				default: begin
					state <= 3'b101;
					shift_ena <= 1'b0;
				end
			endcase
		end
	end
	
endmodule
