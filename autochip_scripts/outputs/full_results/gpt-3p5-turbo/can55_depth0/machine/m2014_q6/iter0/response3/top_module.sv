module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;  // 3-bit register to store the current state

// Define the states using parameters for readability
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

// State transition logic
always @(posedge clk) begin
	if (reset) begin
		state <= A;
	end else begin
		case(state)
			A: state <= w ? A : B;
			B: state <= w ? D : C;
			C: state <= w ? D : E;
			D: state <= w ? A : F;
			E: state <= w ? D : E;
			F: state <= w ? D : C;
			default: state <= A;
		endcase
	end
end

// Output logic
assign z = (state == E || state == F) ? 1'b1 : 1'b0;

endmodule
