module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

// State transition logic
always @(*)
begin
    case (state)
        4'b0001: next_state = in ? 4'b0010 : 4'b0001;  // A: next_state = B if in = 1, else next_state = A
        4'b0010: next_state = in ? 4'b0100 : 4'b0010;  // B: next_state = C if in = 1, else next_state = B
        4'b0100: next_state = in ? 4'b0001 : 4'b1000;  // C: next_state = A if in = 1, else next_state = D
        4'b1000: next_state = in ? 4'b0010 : 4'b0100;  // D: next_state = B if in = 1, else next_state = C
        default: next_state = 4'bxxxx;  // Default case, should not occur
    endcase
end

// Output logic
always @(*)
begin
    case (state)
        4'b1000: out = 1'b1;  // Output is 1 only in state D
        default: out = 1'b0;  // Output is 0 for all other states
    endcase
end

endmodule
