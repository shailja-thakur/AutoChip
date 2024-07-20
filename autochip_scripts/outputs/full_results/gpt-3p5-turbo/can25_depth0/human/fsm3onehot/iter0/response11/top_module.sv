module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

// State transition logic
always @(state, in) begin
    case (state)
        4'b0001: next_state = (in == 1) ? 4'b0010 : 4'b0001; // A -> B, stay in A if in=0
        4'b0010: next_state = (in == 0) ? 4'b0010 : 4'b0100; // B -> B, C if in=1
        4'b0100: next_state = (in == 0) ? 4'b0001 : 4'b1000; // C -> A, D if in=1
        4'b1000: next_state = (in == 0) ? 4'b0100 : 4'b0010; // D -> C, B if in=1
        default: next_state = 4'bxxxx; // undefined state, no transition
    endcase
end

// Output logic
assign out = (state == 4'b1000) ? 1'b1 : 1'b0; // Output is 1 when in state D, 0 otherwise

endmodule
