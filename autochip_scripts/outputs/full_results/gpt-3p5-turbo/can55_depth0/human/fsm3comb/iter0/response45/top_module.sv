module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

// State transition logic

always @(*)
begin
    case (state)
        2'b00: next_state = (in) ? 2'b01 : 2'b00; // A -> B if in=1, otherwise A -> A
        2'b01: next_state = (in) ? 2'b01 : 2'b10; // B -> B if in=1, otherwise B -> C
        2'b10: next_state = (in) ? 2'b11 : 2'b00; // C -> D if in=1, otherwise C -> A
        2'b11: next_state = (in) ? 2'b01 : 2'b10; // D -> B if in=1, otherwise D -> C
        default: next_state = 2'b00; // Default case, go to state A
    endcase
end

// Output logic

always @(*)
begin
    case (state)
        2'b00: out = 1'b0; // Output 0 when in state A
        2'b01: out = 1'b0; // Output 0 when in state B
        2'b10: out = 1'b0; // Output 0 when in state C
        2'b11: out = 1'b1; // Output 1 when in state D
        default: out = 1'b0; // Default case, output 0
    endcase
end

endmodule
