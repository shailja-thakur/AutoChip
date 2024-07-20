module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

// Parameter Definitions
parameter IDLE = 2'b00;
parameter START_BIT = 2'b01;
parameter DATA_BITS = 2'b10;
parameter STOP_BIT = 2'b11;

// Signal Definitions
reg [1:0] state;
reg [7:0] rec_byte;
reg [2:0] bit_counter;

// Output Assignments
assign out_byte = rec_byte;
assign done = (state == STOP_BIT);

// State Transition and Output Logic
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE;
		rec_byte <= 8'b0;
		bit_counter <= 0;
	end else begin
		case (state)
			IDLE: begin
				state <= in ? START_BIT : IDLE;
			end
			
			START_BIT: begin
				if (bit_counter == 7) begin
					state <= STOP_BIT;
				end else begin
					state <= DATA_BITS;
					rec_byte <= {rec_byte[6:0], in};
					bit_counter <= bit_counter + 1;
				end
			end
			
			DATA_BITS: begin
				if (bit_counter == 7) begin
					state <= STOP_BIT;
				end else begin
					state <= DATA_BITS;
					rec_byte <= {rec_byte[6:0], in};
					bit_counter <= bit_counter + 1;
				end
			end
			
			STOP_BIT: begin
				state <= in ? START_BIT : IDLE;
			end
		endcase
	end
end

endmodule
