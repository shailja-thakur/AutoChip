module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	// Declare state register
	reg [2:0] state;

	// Declare internal signals
	reg [7:0] current_byte;
	reg [7:0] next_byte;
	reg next_byte_valid;

	// Declare output signals
	reg done;

	// Synchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 0;
		else
			state <= next_state;
	end

	// Next state logic
	always @* begin
		case(state)
			0: begin
				if (in[3])
					next_state = 1;
				else
					next_state = 0;
			end
			1: begin
				next_state = 2;
			end
			2: begin
				next_state = 3;
			end
			3: begin
				next_state = 0;
			end
		endcase
	end

	// Output logic
	always @(state) begin
		case(state)
			0: begin
				current_byte <= in;
			end
			1: begin
				next_byte <= in;
				next_byte_valid <= 1;
			end
			2: begin
				next_byte <= {next_byte[6:0], in[7]};
				next_byte_valid <= 1;
			end
			3: begin
				current_byte <= next_byte;
				done <= 1;
				next_byte_valid <= 0;
			end
		endcase
	end

	// Done output
	assign done = 0;

endmodule
