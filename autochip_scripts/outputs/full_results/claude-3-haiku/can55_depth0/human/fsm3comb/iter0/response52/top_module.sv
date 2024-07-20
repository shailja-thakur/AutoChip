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
                next_state = (in == 1'b0) ? 2'b00 : 2'b01; // A, B
                out = 1'b0;
            end
        2'b01: // State B
            begin
                next_state = (in == 1'b0) ? 2'b10 : 2'b01; // C, B
                out = 1'b0;
            end
        2'b10: // State C
            begin
                next_state = (in == 1'b0) ? 2'b00 : 2'b11; // A, D
                out = 1'b0;
            end
        2'b11: // State D
            begin
                next_state = (in == 1'b0) ? 2'b10 : 2'b01; // C, B
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
