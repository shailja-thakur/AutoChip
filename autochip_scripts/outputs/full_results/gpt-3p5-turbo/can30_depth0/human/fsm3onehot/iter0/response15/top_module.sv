module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

// State transition logic
always @* begin
    case (state)
        4'b0001: next_state = in ? 4'b0010 : 4'b0001; // A -> B if in=1, else A -> A
        4'b0010: next_state = in ? 4'b0010 : 4'b0100; // B -> B if in=1, else B -> C
        4'b0100: next_state = in ? 4'b1000 : 4'b0001; // C -> D if in=1, else C -> A
        4'b1000: next_state = in ? 4'b0100 : 4'b0010; // D -> C if in=1, else D -> B
        default: next_state = 4'b0000; // Default to all zeros for unknown states
    endcase
end

// Output logic
always @* begin
    case (state)
        4'b0001: out = 1'b0; // Output 0 when in state A
        default: out = 1'b1; // Output 1 for all other states
    endcase
end

endmodule
