module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

always @(*) begin
    case (state)
        2'b00: // State A
            next_state = in ? 2'b01 : 2'b00; // A -> B, A
        2'b01: // State B
            next_state = in ? 2'b01 : 2'b10; // B -> B, C
        2'b10: // State C
            next_state = in ? 2'b11 : 2'b00; // C -> D, A
        2'b11: // State D
            next_state = in ? 2'b01 : 2'b10; // D -> B, C
        default:
            next_state = 2'b00; // Default to state A
    endcase

    out = (state == 2'b11); // Output is 1 only in state D
end

endmodule
