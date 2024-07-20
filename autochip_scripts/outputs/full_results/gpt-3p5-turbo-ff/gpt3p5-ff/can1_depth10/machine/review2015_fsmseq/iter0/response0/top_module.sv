module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	reg [2:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b0; // initial state: S
		else begin
			case (state)
				3'b000: // S
					if (data)
						state <= 3'b001; // S1
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

	assign start_shifting = (state == 3'b101) ? 1'b1 : 1'b0;

endmodule
