module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

	// State Definitions
	enum logic [2:0] state;
	parameter IDLE = 3'b000;
	parameter START_BIT = 3'b001;
	parameter DATA_BIT = 3'b010;
	parameter STOP_BIT = 3'b011;
	parameter VALID_DATA = 3'b100;
	
	// Internal Signals
	logic [7:0] byte;
	
	// Flip-Flops
	reg [2:0] next_state_ff;
	reg [2:0] state_ff;
	reg [7:0] byte_ff;
	reg done_ff;
	
	// Clock and Reset
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state_ff <= IDLE;
			byte_ff <= 8'b0;
			done_ff <= 1'b0;
		end else begin
			state_ff <= next_state_ff;
			byte_ff <= byte;
			done_ff <= (next_state_ff == VALID_DATA) ? 1'b1 : 1'b0;
		end
	end
	
	// Next State Logic
	always @(state_ff or in) begin
		case (state_ff)
			IDLE: begin
				if (in == 1'b0)
					next_state_ff = START_BIT;
				else
					next_state_ff = IDLE;
			end
			START_BIT: begin
				next_state_ff = DATA_BIT;
				byte <= 8'b0;
			end
			DATA_BIT: begin
				byte <= {in, byte[7:1]};
				if ((byte_ff[0] == 1'b1) && (byte_ff == 8'b11111111))
					next_state_ff = STOP_BIT;
				else
					next_state_ff = DATA_BIT;
			end
			STOP_BIT: begin
				if (in == 1'b1)
					next_state_ff = VALID_DATA;
				else
					next_state_ff = STOP_BIT;
			end
			VALID_DATA: begin
				next_state_ff = IDLE;
			end
			default: begin
				next_state_ff = IDLE;
			end
		endcase
	end
	
	// Output Assignment
	assign out_byte = byte_ff;
	assign done = done_ff;
	
endmodule
