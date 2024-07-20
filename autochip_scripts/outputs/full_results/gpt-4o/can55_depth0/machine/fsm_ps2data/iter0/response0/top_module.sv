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
	localparam BYTE1 = 2'b00, BYTE2 = 2'b01, BYTE3 = 2'b10, DONE = 2'b11;

	// State transition logic
	always @(*) begin
		case (state)
			BYTE1: next_state = in[2] ? BYTE2 : BYTE1;
			BYTE2: next_state = BYTE3;
			BYTE3: next_state = DONE;
			DONE: next_state = in[2] ? BYTE1 : BYTE1;
			default: next_state = BYTE1;
		endcase
	end

	// State register
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1;
		end else begin
			state <= next_state;
		end
	end

	// Shift register logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_reg <= 24'b0;
		end else if (state == BYTE1 || state == BYTE2 || state == BYTE3) begin
			shift_reg <= {shift_reg[15:0], in}; // Shift left by 8 bits and add new byte
		end
	end

	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out_bytes <= 24'b0;
			done <= 1'b0;
		end else if (state == DONE) begin
			out_bytes <= shift_reg;
			done <= 1'b1;
		end else begin
			done <= 1'b0;
		end
	end
endmodule
