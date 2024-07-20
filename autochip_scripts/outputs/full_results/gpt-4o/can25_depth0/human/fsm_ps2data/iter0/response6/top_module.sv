module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

typedef enum reg [1:0] {IDLE, BYTE1, BYTE2, BYTE3} state_t;
state_t state, next_state;

reg [7:0] byte1, byte2, byte3;

always @(posedge clk) begin
	if (reset) begin
		state <= IDLE;
		done <= 0;
		out_bytes <= 24'b0;
	end else begin
		state <= next_state;
		case (next_state)
			BYTE1: byte1 <= in;
			BYTE2: byte2 <= in;
			BYTE3: begin
				byte3 <= in;
				out_bytes <= {byte1, byte2, byte3};
			end
		endcase
	end
end

always @(*) begin
	done = 0;
	case (state)
		IDLE: begin
			if (in[3] == 1) 
				next_state = BYTE1;
			else 
				next_state = IDLE;
		end
		BYTE1: next_state = BYTE2;
		BYTE2: next_state = BYTE3;
		BYTE3: begin
			next_state = IDLE;
			done = 1;
		end
		default: next_state = IDLE;
	endcase
end

endmodule
