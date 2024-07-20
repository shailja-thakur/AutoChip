module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

always @(*) begin
    case (state)
        4'b0001: // State A
            if (in == 0) next_state = 4'b0001; // A
            else next_state = 4'b0010; // B
        4'b0010: // State B
            if (in == 0) next_state = 4'b0100; // C
            else next_state = 4'b0010; // B
        4'b0100: // State C
            if (in == 0) next_state = 4'b0001; // A
            else next_state = 4'b1000; // D
        4'b1000: // State D
            if (in == 0) next_state = 4'b0100; // C
            else next_state = 4'b0010; // B
        default:
            next_state = 4'b0001; // Default to state A
    endcase
end

assign out = (state == 4'b1000) ? 1'b1 : 1'b0; // Output is 1 only in state D

endmodule
