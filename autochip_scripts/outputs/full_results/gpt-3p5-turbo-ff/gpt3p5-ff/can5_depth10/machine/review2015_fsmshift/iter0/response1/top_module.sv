module top_module(
	input clk,
	input reset,
	output shift_ena);
	
	reg [2:0] state;
	
	always @(posedge clk) begin
		if (reset == 1'b1) begin
			state <= 3'b000;
		end else begin
			case (state)
				3'b000: begin
					if (shift_ena == 1'b1) begin
						state <= 3'b001;
					end
				end
				
				3'b001: begin
					if (shift_ena == 1'b1) begin
						state <= 3'b010;
					end
				end
				
				3'b010: begin
					if (shift_ena == 1'b1) begin
						state <= 3'b011;
					end
				end
				
				3'b011: begin
					if (shift_ena == 1'b1) begin
						state <= 3'b100;
					end
				end
				
				default: begin
					state <= 3'b100; // Done state
				end
			endcase
		end
	end
	
	assign shift_ena = (state == 3'b000) || (state == 3'b001) || (state == 3'b010) || (state == 3'b011);
	
endmodule
