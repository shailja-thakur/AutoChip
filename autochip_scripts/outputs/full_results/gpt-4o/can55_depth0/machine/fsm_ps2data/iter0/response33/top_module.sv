module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	// Define states
	typedef enum logic [1:0] {
		BYTE1 = 2'b00,
		BYTE2 = 2'b01,
		BYTE3 = 2'b10,
		DONE  = 2'b11
	} state_t;

	state_t state, next_state;
	reg [23:0] byte_reg;

	// State transition logic
	always @(*) begin
		case (state)
			BYTE1: next_state = (in[2]) ? BYTE2 : BYTE1;
			BYTE2:	next_state = BYTE3;
			BYTE3: next_state = DONE;
			DONE: next_state = (in[2]) ? DONE : BYTE1;
			default: next_state = BYTE1;
		endcase
	end

	// State register and output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1;
			byte_reg <= 24'b0;
			done <= 1'b0;
			out_bytes <= 24'b0;
		end else begin
			state <= next_state;
			case (next_state)
				BYTE1, BYTE2, BYTE3: begin
					byte_reg <= {byte_reg[15:0], in};
					done <= 1'b0;
				end
				DONE: begin
					out_bytes <= byte_reg;
					done <= 1'b0;
					byte_reg <= 24'b0;
				end
			endcase
			if (state == DONE) begin
				done <= 1'b1;
			end
		end 
	end

endmodule
