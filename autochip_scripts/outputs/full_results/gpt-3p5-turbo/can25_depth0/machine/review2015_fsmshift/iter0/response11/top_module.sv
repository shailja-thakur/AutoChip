module top_module(
	input clk,
	input reset,
	output shift_ena);
	
	reg [2:0] state; // 3 bit state register
	
	always @(posedge clk) begin
		if (reset) begin
			state <= 3'b000; // Reset to state B0
		end else begin
			case(state)
				3'b000: begin // State B0
					if (shift_ena) begin
						state <= 3'b001; // Go to state B1
					end
				end
				
				3'b001: begin // State B1
					if (shift_ena) begin
						state <= 3'b010; // Go to state B2
					end
				end
				
				3'b010: begin // State B2
					if (shift_ena) begin
						state <= 3'b011; // Go to state B3
					end
				end
				
				3'b011: begin // State B3
					if (shift_ena) begin
						state <= 3'b100; // Go to state Done
					end
				end
				
				default: begin // State Done
					state <= 3'b100; // Stay in state Done
				end
			endcase
		end
	end
	
	assign shift_ena = (state == 3'b000 || state == 3'b001 || state == 3'b010 || state == 3'b011) ? 1'b1 : 1'b0;
	
endmodule
