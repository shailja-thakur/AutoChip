module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

// state definitions
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

// state register
reg [2:0] state;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= A;  // reset state to A
	else begin
		case(state)
			A:
				if (w)
					state <= B;
				else
					state <= A;
			B:
				if (w)
					state <= C;
				else
					state <= D;
			C:
				if (w)
					state <= E;
				else
					state <= D;
			D:
				if (w)
					state <= F;
				else
					state <= A;
			E:
				if (w)
					state <= E;
				else
					state <= D;
			F:
				if (w)
					state <= C;
				else
					state <= D;
		endcase
	end
end

assign z = (state == E || state == F) ? 1'b1 : 1'b0;

endmodule
