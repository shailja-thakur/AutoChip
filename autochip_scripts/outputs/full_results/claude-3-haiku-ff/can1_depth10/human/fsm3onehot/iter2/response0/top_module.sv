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
                next_state = in ? 4'b0010 : 4'b0001; // A -> B, A
                out = 1'b0;
            end
        4'b0010: // State B
            begin
                next_state = in ? 4'b0100 : 4'b0010; // B -> C, B
                out = 1'b0;
            end
        4'b0100: // State C
            begin
                next_state = in ? 4'b1000 : 4'b0001; // C -> D, A
                out = 1'b0;
            end
        4'b1000: // State D
            begin
                next_state = in ? 4'b0010 : 4'b0100; // D -> B, C
                out = 1'b1;
            end
        default:
            begin
                next_state = 4'b0001; // Default to state A
                out = 1'b0;
            end
    endcase
end

endmodule
