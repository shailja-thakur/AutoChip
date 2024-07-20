module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);
	
	// Internal signals
	reg [7:0] shift_reg;
	reg [2:0] state;

	// Constants
	parameter IDLE = 3'b000;
	parameter START_BIT = 3'b001;
	parameter DATA_BIT = 3'b010;
	parameter STOP_BIT = 3'b011;

	// Define register to hold the received byte
	reg [7:0] received_byte;
	
	// Sequential logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// Reset the FSM and all internal signals
			state <= IDLE;
			shift_reg <= 8'b0;
			received_byte <= 8'b0;
		end else begin
			// FSM state transition
			case(state)
				IDLE: begin
					out_byte <= received_byte;
					done <= 1'b0;
					if (in == 1'b0) begin
						state <= START_BIT;
						shift_reg <= 8'b0;
					end
				end
				START_BIT: begin
					state <= DATA_BIT;
					shift_reg <= {shift_reg[6:0], in};
				end
				DATA_BIT: begin
					shift_reg <= {shift_reg[6:0], in};
					if (shift_reg == 0 && in == 1) begin
						state <= STOP_BIT;
					end
				end
				STOP_BIT: begin
					if (in == 1) begin
						received_byte <= shift_reg;
						done <= 1'b1;
						state <= IDLE;
					end
				end
			endcase
		end
	end
endmodule
