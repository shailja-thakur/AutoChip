module top_module (
	input clk,
	input reset,
	input in,
	output reg [7:0] out_byte,
	output reg done
);

	// define states
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA_BITS,
		STOP_BIT
	} state;

	reg [2:0] current_state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= IDLE;
		else
			current_state <= next_state;
	end

	always @(current_state or in) begin
		out_byte <= 8'b0;
		done <= 0;
		next_state <= current_state;

		case (current_state)
			IDLE: begin
				if (in == 1'b0)
					next_state <= START_BIT;
			end
			START_BIT: begin
				if (in == 1'b0)
					next_state <= DATA_BITS;
			end
			DATA_BITS: begin
				if (in == 1'b1)
					next_state <= STOP_BIT;
				else
					out_byte <= {in, out_byte[7:1]}; // shift in the data bits
			end
			STOP_BIT: begin
				if (in == 1'b1) begin
					done <= 1'b1;
					// data byte is valid, reset for next byte
					next_state <= IDLE;
				end else
					next_state <= IDLE;
			end
			default: next_state <= IDLE;
		endcase
	end
endmodule
