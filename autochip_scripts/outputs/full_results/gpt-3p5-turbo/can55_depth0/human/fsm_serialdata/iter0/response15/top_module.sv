module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

// Define the states
typedef enum logic [2:0] {
	IDLE,
	START_BIT,
	DATA_BITS,
	STOP_BIT
} state_t;

// Define the signals
reg [2:0] state;
reg [7:0] data;
reg done;
reg [2:0] count;

// Define the start and stop bit values
parameter START_BIT_VALUE = 1'b0;
parameter STOP_BIT_VALUE = 1'b1;

// Define the FSM logic
always @(posedge clk) begin
	if (reset) begin
		state <= IDLE;
		data <= 8'b0;
		done <= 1'b0;
		count <= 3'b0;
	end else begin
		case (state)
			IDLE: begin
				if (in == START_BIT_VALUE) begin
					state <= START_BIT;
					count <= 3'b0;
				end else begin
					state <= IDLE;
					count <= 3'b0;
				end
			end

			START_BIT: begin
				if (count == 3) begin
					state <= DATA_BITS;
					count <= 3'b0;
				end else begin
					count <= count + 1;
				end
			end

			DATA_BITS: begin
				if (count == 8) begin
					state <= STOP_BIT;
					count <= 3'b0;
				end else begin
					data <= {in, data[7:1]};
					count <= count + 1;
				end
			end

			STOP_BIT: begin
				if (count == 3) begin
					if (in == STOP_BIT_VALUE) begin
						out_byte <= data;
						done <= 1'b1;
					end else begin
						state <= IDLE;
					end
					count <= 3'b0;
				end else begin
					count <= count + 1;
				end
			end
		endcase
	end
end

endmodule
