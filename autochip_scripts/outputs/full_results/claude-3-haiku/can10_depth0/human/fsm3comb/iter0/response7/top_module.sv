module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

always @(*) begin
    case (state)
        2'b00: // State A
            begin
                next_state = in ? 2'b01 : 2'b00; // A -> B, A
                out = 1'b0;
            end
        2'b01: // State B
            begin
                next_state = in ? 2'b01 : 2'b10; // B -> B, C
                out = 1'b0;
            end
        2'b10: // State C
            begin
                next_state = in ? 2'b11 : 2'b00; // C -> D, A
                out = 1'b0;
            end
        2'b11: // State D
            begin
                next_state = in ? 2'b01 : 2'b10; // D -> B, C
                out = 1'b1;
            end
        default:
            begin
                next_state = 2'b00; // Default to state A
                out = 1'b0;
            end
    endcase
end

endmodule
