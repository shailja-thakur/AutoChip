module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

// State transition logic
always @(*)
    case (state)
        4'b0001: next_state = in ? 4'b0010 : 4'b0011;  // A: next_state = B if in = 1, else next_state = C
        4'b0010: next_state = in ? 4'b0100 : 4'b0010;  // B: next_state = C if in = 1, else next_state = B
        4'b0100: next_state = in ? 4'b0001 : 4'b1000;  // C: next_state = A if in = 1, else next_state = D
        4'b1000: next_state = in ? 4'b0100 : 4'b0010;  // D: next_state = C if in = 1, else next_state = B
        default: next_state = 4'bzzzz;  // Default case
    endcase

// Output logic
always @(*)
    case (state)
        4'b1000: out = 1'b1;  // Output is 1 only in state D
        default: out = 1'b0;
    endcase

endmodule
