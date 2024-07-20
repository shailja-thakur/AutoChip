module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// FSM State Declaration
	typedef enum reg [1:0] {
		IDLE,        // Waiting for start byte
		BYTE1,       // Received the first byte
		BYTE2,       // Received the second byte
		BYTE3        // Received the third byte
	} state_t;
	
	state_t current_state, next_state;
	reg [23:0] data_reg;

	// Sequential logic for FSM state transition
	always @(posedge clk) begin
		if (reset) begin
			current_state <= IDLE;
		end else begin
			current_state <= next_state;
		end
	end

	// Combinational logic for next state and output logic
	always @(*) begin
		// Default values
		next_state = current_state;
		done = 0;

		case (current_state)
			IDLE: begin
				if (in[3]) begin
					data_reg[23:16] = in;
					next_state = BYTE1;
				end
			end
			BYTE1: begin
				data_reg[15:8] = in;
				next_state = BYTE2;
			end
			BYTE2: begin
				data_reg[7:0] = in;
				next_state = BYTE3;
			end
			BYTE3: begin
				out_bytes = data_reg;
				done = 1;
				if (in[3]) begin
					data_reg[23:16] = in;
					next_state = BYTE1;
				end else begin
					next_state = IDLE;
				end
			end
		endcase
	end

	// Output assignment
	always @(posedge clk) begin
		if (reset) begin
			out_bytes <= 0;
		end else if (done) begin
			out_bytes <= data_reg;
		end else begin
			out_bytes <= 24'bx;
		end
	end

endmodule
