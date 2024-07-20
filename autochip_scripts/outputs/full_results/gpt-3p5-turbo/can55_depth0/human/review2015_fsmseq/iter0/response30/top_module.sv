module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	// Internal state variables
	reg [1:0] state;

	// Next state logic
	always @(posedge clk) begin
		if (reset)
			state <= 2'b00;
		else begin
			case (state)
				2'b00: begin
					if (data)
						state <= 2'b01;
					else
						state <= 2'b00;
				end
				2'b01: begin
					if (data)
						state <= 2'b10;
					else
						state <= 2'b00;
				end
				2'b10: begin
					if (data)
						state <= 2'b11;
					else
						state <= 2'b00;
				end
				2'b11: begin
					if (data)
						state <= 2'b11;
					else
						state <= 2'b00;
				end
			endcase
		end
	end

	// Output logic
	always @(state) begin
		if (state == 2'b11)
			start_shifting <= 1'b1;
		else
			start_shifting <= 1'b0;
	end

endmodule
