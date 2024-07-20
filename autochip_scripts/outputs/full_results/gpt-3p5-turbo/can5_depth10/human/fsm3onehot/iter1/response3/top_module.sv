module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

// State transition logic
always @(*)
    case (state)
        4'b0001: next_state = in ? 4'b0011 : 4'b0010;  // A: next_state = B if in = 1, else next_state = A
        4'b0010: next_state = in ? 4'b0010 : 4'b0100;  // B: next_state = B if in = 1, else next_state = C
        4'b0100: next_state = in ? 4'b1000 : 4'b0001;  // C: next_state = D if in = 1, else next_state = A
        4'b1000: next_state = in ? 4'b0100 : 4'b0010;  // D: next_state = C if in = 1, else next_state = B
        default: next_state = 4'bxxxx;  // Default case, should not occur
    endcase

// Output logic
always @(*)
    case (state)
        4'b0001: out = 1'b0;  // A: output is 0
        default: out = 1'b1;  // Other states: output is 1
    endcase

endmodule
