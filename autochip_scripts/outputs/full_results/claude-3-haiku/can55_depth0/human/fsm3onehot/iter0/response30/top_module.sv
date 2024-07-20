module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

// State transition logic
always @(*) begin
    case (state)
        4'b0001: // State A
            next_state = in ? 4'b0010 : 4'b0001; // A, B
        4'b0010: // State B
            next_state = in ? 4'b0010 : 4'b0100; // B, C
        4'b0100: // State C
            next_state = in ? 4'b1000 : 4'b0001; // D, A
        4'b1000: // State D
            next_state = in ? 4'b0010 : 4'b0100; // B, C
        default:
            next_state = 4'b0001; // Default to state A
    endcase
end

// Output logic
assign out = (state == 4'b1000) ? 1'b1 : 1'b0; // Output is 1 in state D, 0 otherwise

endmodule
