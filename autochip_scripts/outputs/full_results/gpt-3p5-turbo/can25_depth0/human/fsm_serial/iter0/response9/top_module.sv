module top_module (
	input clk,
	input in,
	input reset,
	output done
);

reg [3:0] state;   // FSM state register
reg start_found;   // flag indicating start bit found
reg done_flag;     // flag indicating byte received
reg [7:0] data;    // received data register

// FSM states
parameter IDLE = 0;
parameter START_BIT = 1;
parameter DATA_BITS = 2;
parameter STOP_BIT = 3;

// Define the state transitions and outputs
always @(posedge clk) begin
	if (reset) begin
		state <= IDLE;
		start_found <= 0;
		done_flag <= 0;
		data <= 0;
	end
	else begin
		case (state)
			IDLE: begin
				if (in == 0) begin
					state <= START_BIT;
					start_found <= 1;
				end
				else begin
					state <= IDLE;
					start_found <= 0;
				end
			end
			
			START_BIT: begin
				state <= DATA_BITS;
			end
			
			DATA_BITS: begin
				if (in == 1) begin
					data <= {data[6:0], in};
				end
				else begin
					state <= STOP_BIT;
				end
			end
			
			STOP_BIT: begin
				if (in == 1) begin
					state <= IDLE;
					done_flag <= 1;
				end
				else begin
					state <= STOP_BIT;
				end
			end
		endcase
	end
end

assign done = done_flag;

endmodule
