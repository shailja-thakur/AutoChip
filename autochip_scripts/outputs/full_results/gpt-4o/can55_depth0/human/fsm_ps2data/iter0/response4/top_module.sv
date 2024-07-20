module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// States for FSM
	typedef enum reg [1:0] {
		IDLE,
		BYTE1,
		BYTE2,
		BYTE3
	} state_t;

	state_t state, next_state;
	reg [23:0] message;
	reg [7:0] byte1, byte2, byte3;

	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
		end else begin
			state <= next_state;
		end
	end

	// Next state and output logic
	always @(*) begin
		// Default assignments
		next_state = state;
		done = 0;
		out_bytes = 24'bx;
		case (state)
			IDLE: begin
				if (in[3]) begin
					next_state = BYTE1;
				end
			end

			BYTE1: begin
				next_state = BYTE2;
			end
			
			BYTE2: begin
				next_state = BYTE3;
			end

			BYTE3: begin
				done = 1;
				next_state = IDLE;
			end
		endcase
	end

	// Data storage logic
	always @(posedge clk) begin
		if (reset) begin
			byte1 <= 8'b0;
			byte2 <= 8'b0;
			byte3 <= 8'b0;
			out_bytes <= 24'b0;
		end else begin
			case (state)
				BYTE1: byte1 <= in;
				BYTE2: byte2 <= in;
				BYTE3: byte3 <= in;
			endcase
			if (done) begin
				out_bytes <= {byte1, byte2, byte3};
			end
		end
	end

endmodule
