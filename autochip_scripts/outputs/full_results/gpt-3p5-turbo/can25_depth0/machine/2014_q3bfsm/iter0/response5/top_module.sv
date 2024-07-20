module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

reg [2:0] state;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 3'b000; // A
	else begin
		case (state)
			3'b000: begin // A
				if (x)
					state <= 3'b001; // B
				else
					state <= 3'b000; // A
			end
			3'b001: begin // B
				if (x)
					state <= 3'b100; // E
				else
					state <= 3'b001; // B
			end
			3'b010: begin // C
				if (x)
					state <= 3'b001; // B
				else
					state <= 3'b010; // C
			end
			3'b011: begin // D
				if (x)
					state <= 3'b010; // C
				else
					state <= 3'b001; // B
			end
			3'b100: begin // E
				if (x)
					state <= 3'b100; // E
				else
					state <= 3'b011; // D
			end
			default: state <= 3'b000; // A
		endcase
	end
end

always @(state) begin
	if (state == 3'b011 || state == 3'b100)
		z <= 1'b1; // Output is high when state is D or E
	else
		z <= 1'b0;
end

endmodule
