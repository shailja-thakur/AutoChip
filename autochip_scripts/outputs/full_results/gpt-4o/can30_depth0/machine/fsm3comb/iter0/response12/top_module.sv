module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

    // State Encoding
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;

    // Combinational logic for state transitions
    always @* begin
        case (state)
            A: if (in) next_state = B; else next_state = A;
            B: if (in) next_state = B; else next_state = C;
            C: if (in) next_state = D; else next_state = A;
            D: if (in) next_state = B; else next_state = C;
            default: next_state = A; // Default case to avoid latches
        endcase
    end

    // Output logic
    assign out = (state == D);

endmodule
