module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
	reg [23:0] out_reg;
	reg [1:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00;
			out_reg <= 0;
			done <= 0;
		end else begin
			case (state)
				2'b00: begin
					if (in[2] == 1) begin
						state <= 2'b01;
					end else begin
						state <= 2'b00;
					end
				end
				
				2'b01: begin
					state <= 2'b10;
				end
				
				2'b10: begin
					state <= 2'b11;
				end
				
				2'b11: begin
					state <= 2'b00;
				end
			endcase
			
			if ((state == 2'b11 && in[2] == 0) || state == 2'b00) begin
				out_reg <= {out_reg[15:0], in};
			end
		end
	end
	
	assign out_bytes = done ? out_reg : 0;
	assign done = state == 2'b11 ? 1 : 0;
endmodule
