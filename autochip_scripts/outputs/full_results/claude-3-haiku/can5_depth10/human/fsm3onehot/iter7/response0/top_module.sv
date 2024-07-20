module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

always @(*) begin
    case (state)
        4'b0001: // State A
            begin
                next_state = in ? 4'b0010 : 4'b0001; // A, B
                out = 1'b0; // Output is 0 in state A
            end
        4'b0010: // State B
            begin
                next_state = in ? 4'b0100 : 4'b0010; // C, B
                out = 1'b0; // Output is 0 in state B
            end
        4'b0100: // State C
            begin
                next_state = in ? 4'b1000 : 4'b0001; // D, A
                out = 1'b0; // Output is 0 in state C
            end
        4'b1000: // State D
            begin
                next_state = in ? 4'b0010 : 4'b0100; // B, C
                out = 1'b1; // Output is 1 in state D
            end
        default:
            begin
                next_state = 4'b0001; // Default to state A
                out = 1'b0; // Default output is 0
            end
    endcase
end

endmodule
