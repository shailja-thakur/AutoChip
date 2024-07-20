module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [2:0] state;
	always @(posedge clk) begin
		if (reset)
			state <= 3'b0; // initial state: S
		else begin
			case (state)
				3'b000: // S
					if (data)
						state <= 3'b001; // S1
					else
						state <= 3'b000; // S
				3'b001: // S1
					if (data)
						state <= 3'b011; // S11
					else
						state <= 3'b000; // S
				3'b011: // S11
					if (data)
						state <= 3'b011; // S11
					else
						state <= 3'b100; // S110
				3'b100: // S110
					if (data)
						state <= 3'b101; // Done
					else
						state <= 3'b000; // S
				3'b101: // Done
					state <= 3'b101; // Done
			endcase
		end
	end

	always @(*) begin
		if (state == 3'b101)
			start_shifting = 1'b1;
		else
			start_shifting = 1'b0;
	end

endmodule
