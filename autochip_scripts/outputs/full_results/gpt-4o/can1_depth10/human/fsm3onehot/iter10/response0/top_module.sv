module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);
    // State encoding
    parameter A = 4'b0001;
    parameter B = 4'b0010;
    parameter C = 4'b0100;
    parameter D = 4'b1000;

    // Combinational logic for state transition
    always @(*) begin
        // Default next state to the current state (to avoid latches)
        next_state = 4'b0000; // Default to an invalid state for safety

        // Handle only one-hot state inputs properly
        case (state)
            4'b0001: next_state = (in) ? B : A; // state A
            4'b0010: next_state = (in) ? B : C; // state B
            4'b0100: next_state = (in) ? D : A; // state C
            4'b1000: next_state = (in) ? B : C; // state D
            default: next_state = A; // Reset to state A in case of invalid one-hot state
        endcase
    end

    // Combinational logic for output
    always @(*) begin
        // Default output to 0
        out = 0;

        // Handle only one-hot state inputs properly
        case (state)
            4'b0001: out = 0; // state A
            4'b0010: out = 0; // state B
            4'b0100: out = 0; // state C
            4'b1000: out = 1; // state D
            default: out = 0; // Default output for invalid one-hot states
        endcase
    end
endmodule
