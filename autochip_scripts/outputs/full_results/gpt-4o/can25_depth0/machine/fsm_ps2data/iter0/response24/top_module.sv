module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// State encoding
	typedef enum logic [1:0] {
		BYTE1 = 2'b00,
		BYTE2 = 2'b01,
		BYTE3 = 2'b10,
		DONE  = 2'b11
	} state_t;

	state_t state, next_state;
	reg [23:0] register;

	// State transition
	always @(*) begin
		case (state)
			BYTE1: next_state = (in[2] == 1) ? BYTE2 : BYTE1;
			BYTE2: next_state = BYTE3;
			BYTE3: next_state = DONE;
			DONE: next_state  = (in[2] == 1) ? BYTE2 : BYTE1;
			default: next_state = BYTE1;
		endcase
	end

	// State update and output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1;
			register <= 24'd0;
			done <= 1'b0;
		end else begin
			state <= next_state;
			case (state)
				BYTE1: begin
					register <= {register[15:0], in}; // Shift left and insert input byte
					done <= 1'b0;
				end
				BYTE2: begin
					register <= {register[15:0], in}; // Shift left and insert input byte
					done <= 1'b0;
				end
				BYTE3: begin
					register <= {register[15:0], in}; // Shift left and insert input byte
					done <= 1'b0;
				end
				DONE: begin
					out_bytes <= register; // Output the final 24-bit value
					done <= 1'b1;
				end
			endcase
		end
	end

endmodule
