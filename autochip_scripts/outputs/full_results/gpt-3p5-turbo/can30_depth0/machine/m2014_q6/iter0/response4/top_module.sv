module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// Define the states
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter D = 3;
parameter E = 4;
parameter F = 5;

reg [2:0] state;
reg z;

// Next state logic
always @(posedge clk or posedge reset)
begin
	if (reset)
		state <= A;
	else
		case(state)
			A: state <= (w == 1'b0) ? B : A;
			B: state <= (w == 1'b1) ? D : C;
			C: state <= (w == 1'b0) ? E : D;
			D: state <= (w == 1'b1) ? A : F;
			E: state <= (w == 1'b0) ? D : E;
			F: state <= (w == 1'b1) ? D : C;
		endcase
end

// Output logic
always @(state)
begin
	case(state)
		E, F: z <= 1'b1;
		default: z <= 1'b0;
	endcase
end

endmodule
