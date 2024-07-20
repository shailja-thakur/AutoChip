module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [23:0] message;
reg [3:0] state;
reg [3:0] next_state;

// State definitions
parameter IDLE_STATE = 0;
parameter SEARCH_STATE = 1;
parameter FIRST_BYTE_STATE = 2;
parameter SECOND_BYTE_STATE = 3;
parameter THIRD_BYTE_STATE = 4;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= IDLE_STATE;
		message <= 0;
	end else begin
		state <= next_state;
		message <= {message[15:0], in}; // Shift in the current input byte
	end
end

always @* begin
	next_state = state;

	case (state)
		IDLE_STATE: begin
			if (in[3] == 1)
				next_state = SEARCH_STATE;
		end

		SEARCH_STATE: begin
			if (in[3] == 1) begin
				next_state = FIRST_BYTE_STATE;
				message <= 0;
			end
		end

		FIRST_BYTE_STATE: begin
			next_state = SECOND_BYTE_STATE;
		end

		SECOND_BYTE_STATE: begin
			next_state = THIRD_BYTE_STATE;
		end

		THIRD_BYTE_STATE: begin
			next_state = IDLE_STATE;
			done = 1;
		end

		default: next_state = IDLE_STATE;
	endcase
end

assign out_bytes = message;

endmodule
