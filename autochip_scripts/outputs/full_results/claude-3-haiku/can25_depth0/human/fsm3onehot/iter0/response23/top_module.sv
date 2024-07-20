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
            next_state = in ? 4'b0010 : 4'b0001; // A -> B, A
        4'b0010: // State B
            next_state = in ? 4'b0010 : 4'b0100; // B -> B, C
        4'b0100: // State C
            next_state = in ? 4'b1000 : 4'b0001; // C -> D, A
        4'b1000: // State D
            next_state = in ? 4'b0010 : 4'b0100; // D -> B, C
        default:
            next_state = 4'b0000; // Default case
    endcase
end

// Output logic
assign out = (state == 4'b1000); // Output is 1 when in state D, 0 otherwise

endmodule
