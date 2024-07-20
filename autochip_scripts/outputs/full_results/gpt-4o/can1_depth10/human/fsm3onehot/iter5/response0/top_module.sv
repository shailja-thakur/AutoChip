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
        next_state = state;

        case (state)
            A: next_state = (in) ? B : A;
            B: next_state = (in) ? B : C;
            C: next_state = (in) ? D : A;
            D: next_state = (in) ? B : C;
            default: next_state = 4'b0000;  // Default to an invalid state for safety
        endcase
    end

    // Combinational logic for output
    always @(*) begin
        // Default output to 0
        out = 0;

        case (state)
            A: out = 0;
            B: out = 0;
            C: out = 0;
            D: out = 1;
            default: out = 0;
        endcase
    end
endmodule
