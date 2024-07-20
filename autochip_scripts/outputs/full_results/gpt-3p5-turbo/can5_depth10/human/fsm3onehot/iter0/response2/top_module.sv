module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

// State transition logic
always @(*)
    case (state)
        4'b0001: next_state = in ? 4'b0010 : 4'b0001;  // A: next_state = B if in = 1, else next_state = A
        4'b0010: next_state = in ? 4'b0010 : 4'b0100;  // B: next_state = B if in = 1, else next_state = C
        4'b0100: next_state = in ? 4'b1000 : 4'b0001;  // C: next_state = D if in = 1, else next_state = A
        4'b1000: next_state = in ? 4'b0100 : 4'b0010;  // D: next_state = C if in = 1, else next_state = B
        default: next_state = 4'bxxxx;  // Default case, should not occur
    endcase

// Output logic
assign out = (state == 4'b1000);  // Output is 1 only in state D, else it is 0

endmodule
