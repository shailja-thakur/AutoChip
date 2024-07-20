module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

// State declaration
typedef enum logic [1:0] {
	IDLE,
	SEARCHING,
	BYTE1,
	BYTE2,
	BYTE3
} state_t;

// Outputs
reg done;

// Internal signals
reg [1:0] state;
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

// Sequential logic
always @(posedge clk) begin
	if (reset) begin
		state <= IDLE;
		byte1 <= 0;
		byte2 <= 0;
		byte3 <= 0;
		done <= 0;
	end else begin
		case (state)
			IDLE:
				if (in[3] == 1'b1) begin
					byte1 <= in;
					state <= BYTE1;
				end
			BYTE1:
				byte2 <= in;
				state <= BYTE2;
			BYTE2:
				byte3 <= in;
				state <= BYTE3;
			BYTE3:
				done <= 1;
				state <= SEARCHING;
			SEARCHING:
				if (in[3] == 1'b1) begin
					byte1 <= in;
					state <= BYTE1;
				end
		endcase
	end
end

endmodule
