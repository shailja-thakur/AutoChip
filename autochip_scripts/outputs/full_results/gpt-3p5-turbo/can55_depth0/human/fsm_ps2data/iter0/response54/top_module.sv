module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
	reg [7:0] in_reg;
	reg [7:0] byte1_reg, byte2_reg, byte3_reg;
	reg [2:0] state_reg;
	
	always @(posedge clk) begin
		if (reset) begin
			in_reg <= 8'b0;
			byte1_reg <= 8'b0;
			byte2_reg <= 8'b0;
			byte3_reg <= 8'b0;
			state_reg <= 3'b0;
		end else begin
			in_reg <= in;
			
			case (state_reg)
				3'b000: begin
					if (in[3] == 1'b1) begin
						byte1_reg <= in_reg;
						state_reg <= 3'b001;
					end else begin
						byte1_reg <= 8'b0;
						state_reg <= 3'b000;
					end
				end
				
				3'b001: begin
					byte2_reg <= in_reg;
					state_reg <= 3'b010;
				end
				
				3'b010: begin
					byte3_reg <= in_reg;
					state_reg <= 3'b011;
				end
				
				3'b011: begin
					byte1_reg <= 8'b0;
					byte2_reg <= 8'b0;
					byte3_reg <= 8'b0;
					state_reg <= 3'b000;
					done <= 1'b1;
				end
				
				default: begin
					state_reg <= 3'b000;
				end
			endcase
		end
	end
	
	assign out_bytes = {byte1_reg, byte2_reg, byte3_reg};
endmodule
