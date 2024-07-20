module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

// State definition
typedef enum logic [1:0] {
	BYTE1,
	BYTE2,
	BYTE3,
	DONE
} state_t;
	
// State and next state signals
state_t current_state;
state_t next_state;

// State register
always @(posedge clk) begin
	if (reset) begin
		current_state <= BYTE1;
	end else begin
		current_state <= next_state;
	end
end

// Next state logic
always @* begin
	case (current_state)
		BYTE1:
			if (in[2] == 1) begin
				next_state = BYTE2;
			end else begin
				next_state = BYTE1;
			end
		BYTE2:
			if (in[2] == 1) begin
				next_state = BYTE3;
			end else begin
				next_state = BYTE2;
			end
		BYTE3:
			next_state = DONE;
		DONE:
			if (in[2] == 0) begin
				next_state = BYTE1;
			end else begin
				next_state = DONE;
			end
	endcase
end

// Output logic
always @(posedge clk) begin
	if (reset) begin
		out_bytes <= 0;
		done <= 0;
	end else begin
		case (current_state)
			BYTE1:
				out_bytes <= {out_bytes[15:0], in};
			BYTE2:
				out_bytes <= {out_bytes[15:0], in};
			BYTE3:
				out_bytes <= {out_bytes[15:0], in};
			DONE:
				if (done) begin
					out_bytes <= {out_bytes[15:0], in};
				end
		endcase
	end
end

// Done signal logic
always @* begin
	if (current_state == DONE) begin
		done = 1;
	end else begin
		done = 0;
	end
end

endmodule
