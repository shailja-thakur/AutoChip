module top_module (
	input clk,
	input in,
	input reset,
	output done
);

// Define the states
parameter IDLE = 2'b00;
parameter START_BIT = 2'b01;
parameter DATA_BITS = 2'b10;
parameter STOP_BIT = 2'b11;

// Define the inputs used in the FSM
reg [1:0] current_state;
reg [7:0] data;
reg start_bit_detected;
reg stop_bit_detected;
wire start_bit_expected;
wire stop_bit_expected;

// Perform the state transitions
always @(posedge clk or posedge reset) begin
	if (reset) begin
		current_state <= IDLE;
		data <= 0;
		start_bit_detected <= 0;
		stop_bit_detected <= 0;
	end
	else begin
		case (current_state)
			IDLE: begin
				if (in == 0) begin
					current_state <= START_BIT;
					start_bit_detected <= 1;
				end
				else begin
					current_state <= IDLE;
					start_bit_detected <= 0;
				end
			end
			
			START_BIT: begin
				if (in == 0) begin
					current_state <= DATA_BITS;
					start_bit_detected <= 0;
					data <= {in, data[7:1]};
				end
				else begin
					current_state <= IDLE;
					start_bit_detected <= 0;
				end
			end
			
			DATA_BITS: begin
				if (in == 0) begin
					current_state <= DATA_BITS;
					data <= {in, data[7:1]};
				end
				else begin
					current_state <= STOP_BIT;
					stop_bit_detected <= 1;
					data <= {in, data[7:1]};
				end
			end
			
			STOP_BIT: begin
				if (in == 1) begin
					current_state <= IDLE;
					stop_bit_detected <= 0;
					if (stop_bit_expected) begin
						done <= 1;
					end
				end
				else begin
					current_state <= IDLE;
					stop_bit_detected <= 0;
				end
			end
		endcase
	end
end

// Determine when the start and stop bits are expected
assign start_bit_expected = (current_state == START_BIT) ? 1 : 0;
assign stop_bit_expected = (current_state == STOP_BIT) ? 1 : 0;

endmodule
