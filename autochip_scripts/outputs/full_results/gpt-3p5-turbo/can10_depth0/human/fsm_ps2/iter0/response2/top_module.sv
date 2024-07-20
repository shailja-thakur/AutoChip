module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

	reg [7:0] buffer [2:0];
	reg [1:0] state;

	// Initialize
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;
		else
			state <= state;
	end

	// Shift the buffer and add the new input
	always @(posedge clk or posedge reset) begin
		if (reset)
			buffer[0] <= 8'b0;
		else if (state == 2'b11)
			buffer[0] <= {buffer[0][6:0], in[6:0]};
		else
			buffer[0] <= buffer[0];
	end

	// Transition logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;
		else begin
			case (state)
				2'b00:
					if (in[3])
						state <= 2'b01;
					else
						state <= 2'b00;
				2'b01:
					state <= 2'b10;
				2'b10:
					state <= 2'b11;
				2'b11:
					if (in[3])
						state <= 2'b01;
					else
						state <= 2'b00;
				default:
					state <= 2'b00;
			endcase
		end
	end

	// Output logic
	assign done = (state == 2'b11);

endmodule
