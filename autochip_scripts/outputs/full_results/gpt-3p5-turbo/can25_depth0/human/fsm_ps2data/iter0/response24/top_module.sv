module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);
	reg [7:0] byte1_reg, byte2_reg, byte3_reg;
	reg [2:0] state_reg, next_state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			byte1_reg <= 8'b0;
			byte2_reg <= 8'b0;
			byte3_reg <= 8'b0;
			state_reg <= 3'b0;
		end else begin
			byte1_reg <= in;
			byte2_reg <= byte1_reg;
			byte3_reg <= byte2_reg;
			state_reg <= next_state;
		end
	end
	
	always @(state_reg or byte3_reg) begin
		case (state_reg)
			3'b0: begin
				if (byte3_reg[3] == 1'b1) begin
					next_state = 3'b1;
				end else begin
					next_state = 3'b0;
				end
			end
			
			3'b1: begin
				next_state = 3'b2;
			end
			
			3'b2: begin
				next_state = 3'b3;
			end
			
			3'b3: begin
				next_state = 3'b0;
				done = 1'b1;
			end
			
			default: next_state = 3'b0;
		endcase
	end
	
	always @(posedge clk) begin
		if (reset) begin
			out_bytes <= 24'b0;
		end else if (done) begin
			out_bytes <= {byte3_reg, byte2_reg, byte1_reg};
		end
	end
endmodule
