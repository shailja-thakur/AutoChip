module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

    // Define state codes
	localparam A = 2'b00;
	localparam B = 2'b01;
	localparam C = 2'b10;
	localparam D = 2'b11;

    // Always block for combinational logic to determine next state
	always @(*) begin
		case(state)
			A: next_state = (in) ? B : A;
			B: next_state = (in) ? B : C;
			C: next_state = (in) ? D : A;
			D: next_state = (in) ? B : C;
			default: next_state = A;  // Default case for safety
		endcase
	end

    // Assign out signal high when in state D
	assign out = (state == D);

endmodule
