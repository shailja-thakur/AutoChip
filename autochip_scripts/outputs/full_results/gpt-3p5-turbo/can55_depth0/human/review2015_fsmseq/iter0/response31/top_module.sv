module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	// State definitions
	parameter IDLE = 2'b00;
	parameter START = 2'b01;
	parameter SHIFTING = 2'b10;
	
	// Internal signals
	reg [1:0] state;
	reg [3:0] shift_reg;
	
	// Sequential logic
	always @(posedge clk, posedge reset) begin
		if (reset)
			state <= IDLE;
		else begin
			case (state)
				IDLE: begin
					if (data)
						state <= START;
				end
				START: begin
					shift_reg <= 4'b0000;
					state <= SHIFTING;
				end
				SHIFTING: begin
					shift_reg <= {shift_reg[2:0], data};
					if (shift_reg == 4'b1101)
						start_shifting <= 1;
				end
			endcase
		end
	end
	
endmodule
