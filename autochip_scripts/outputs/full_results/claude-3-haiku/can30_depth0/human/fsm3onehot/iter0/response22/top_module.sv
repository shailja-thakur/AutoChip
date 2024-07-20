module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

always @(*) begin
    case (state)
        4'b0001: // State A
            next_state = in ? 4'b0010 : 4'b0001; // Next state in=0: A, in=1: B
        4'b0010: // State B
            next_state = in ? 4'b0010 : 4'b0100; // Next state in=0: C, in=1: B
        4'b0100: // State C
            next_state = in ? 4'b1000 : 4'b0001; // Next state in=0: A, in=1: D
        4'b1000: // State D
            next_state = in ? 4'b0010 : 4'b0100; // Next state in=0: C, in=1: B
        default:
            next_state = 4'b0001; // Default to state A
    endcase
end

assign out = (state == 4'b1000); // Output is 1 when in state D, 0 otherwise

endmodule
