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
	START,
	RECEIVE,
	STOP
} state;

reg [2:0] current_state;
reg [7:0] received_byte;
reg done;

// Next state logic
always_ff @(posedge clk, posedge reset) begin
	if (reset) begin
		current_state <= IDLE;
		received_byte <= 8'b0;
		done <= 0;
	end else begin
		case (current_state)
			IDLE: begin
				if (in == 1'b0) begin
					current_state <= START;
					received_byte <= 8'b0;
					done <= 0;
				end else begin
					current_state <= IDLE;
					received_byte <= 8'b0;
					done <= 0;
				end
			end
			START: begin
				current_state <= RECEIVE;
				received_byte <= 8'b0;
				done <= 0;
			end
			RECEIVE: begin
				if (received_byte[7] == 1'b0) begin
					received_byte <= {received_byte[6:0], in};
					done <= 0;
				end else begin
					current_state <= STOP;
					received_byte <= {received_byte[6:0], in};
					done <= 0;
				end
			end
			STOP: begin
				if (in == 1'b1) begin
					current_state <= IDLE;
					done <= 1;
				end else begin
					current_state <= STOP;
					done <= 0;
				end
			end
		endcase
	end
end

// Output logic
always_comb begin
	out_byte = received_byte;
end

endmodule
