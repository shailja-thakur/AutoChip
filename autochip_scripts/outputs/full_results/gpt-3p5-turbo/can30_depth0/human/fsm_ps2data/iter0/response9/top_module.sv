module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
	
	reg [23:0] out_reg;
	reg [2:0] state_reg;
	
	// FSM states
	localparam IDLE = 3'd0;
	localparam BYTE1 = 3'd1;
	localparam BYTE2 = 3'd2;
	localparam BYTE3 = 3'd3;
	
	always @(posedge clk) begin
		if (reset) begin
			out_reg <= 0;    // Initialize output register
			state_reg <= IDLE;    // Initialize state register
		end else begin
			case(state_reg)
				
				IDLE: begin
					if (in[3] == 1) begin
						state_reg <= BYTE1;
					end
				end
				
				BYTE1: begin
					out_reg[23:16] <= in;
					state_reg <= BYTE2;
				end
			
				BYTE2: begin
					out_reg[15:8] <= in;
					state_reg <= BYTE3;
				end
				
				BYTE3: begin
					out_reg[7:0] <= in;
					state_reg <= IDLE;
				end
				
			endcase
		end
	end
	
	assign out_bytes = out_reg;
	assign done = (state_reg == BYTE3);
	
endmodule
