module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	reg [1:0] state, next_state;
	reg [23:0] shift_reg;

	// State encoding
	localparam BYTE1 = 2'd0,
	           BYTE2 = 2'd1,
	           BYTE3 = 2'd2,
	           DONE  = 2'd3;

	// State transition logic
	always @(*) begin
		case (state)
			BYTE1: if (in[2]) next_state = BYTE2;
			       else next_state = BYTE1;
			BYTE2: next_state = BYTE3;
			BYTE3: next_state = DONE;
			DONE:  if (reset) next_state = BYTE1;
			       else next_state = DONE;
			default: next_state = BYTE1;
		endcase
	end

	// State register
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1;
			shift_reg <= 24'b0;
			done <= 1'b0;
			out_bytes <= 24'b0;
		end else begin
			state <= next_state;
			
			// Shift input into the register
			if (state != DONE) begin
				shift_reg <= (shift_reg << 8) | in;
			end
			
			// Update done signal and output
			if (next_state == DONE) begin
				out_bytes <= shift_reg;
				done <= 1'b1;
			end else begin
				done <= 1'b0;
			end
		end
	end

endmodule
