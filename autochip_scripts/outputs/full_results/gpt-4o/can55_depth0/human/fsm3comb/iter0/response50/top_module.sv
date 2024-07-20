module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

    // Defining state codes
    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

    // Combinational logic for state transition
    always @(*) begin
        case (state)
            A: next_state = (in == 0) ? A : B;
            B: next_state = (in == 0) ? C : B;
            C: next_state = (in == 0) ? A : D;
            D: next_state = (in == 0) ? C : B;
            default: next_state = A; // Default to avoid latches
        endcase
    end

    // Output logic, which is dependent only on the current state
    assign out = (state == D) ? 1 : 0;

endmodule
