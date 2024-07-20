module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 2'b00;
	else begin
		case(state)
			0: begin // state A
				if (in)
					state <= 2'b10; // next state D
				else
					state <= 2'b01; // next state B
			end
			1: begin // state B
				if (in)
					state <= 2'b11; // next state C
				else
					state <= 2'b01; // next state B
			end
			2: begin // state C
				if (in)
					state <= 2'b10; // next state D
				else
					state <= 2'b00; // next state A
			end
			3: begin // state D
				if (in)
					state <= 2'b11; // next state C
				else
					state <= 2'b01; // next state B
			end
		endcase
	end
end

always @(state) begin
	case(state)
		0: out = 0; // state A
		1: out = 0; // state B
		2: out = 0; // state C
		3: out = 1; // state D
	endcase
end

endmodule
