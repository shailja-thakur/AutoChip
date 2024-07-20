module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output out
);

always @(*) begin
    case (state)
        2'b00: // State A
            begin
                next_state = (in == 1'b0) ? 2'b00 : 2'b01; // A -> A, B
                out = 1'b0;
            end
        2'b01: // State B
            begin
                next_state = (in == 1'b0) ? 2'b10 : 2'b01; // B -> C, B
                out = 1'b0;
            end
        2'b10: // State C
            begin
                next_state = (in == 1'b0) ? 2'b00 : 2'b11; // C -> A, D
                out = 1'b0;
            end
        2'b11: // State D
            begin
                next_state = (in == 1'b0) ? 2'b10 : 2'b01; // D -> C, B
                out = 1'b1;
            end
        default:
            begin
                next_state = 2'b00;
                out = 1'b0;
            end
    endcase
end

endmodule
