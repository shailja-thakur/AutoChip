module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

always_comb begin
    case (state)
        2'b00: // State A
            if (in) begin
                next_state = 2'b01; // Go to state B
            end else begin
                next_state = 2'b00; // Stay in state A
            end
        2'b01: // State B
            if (in) begin
                next_state = 2'b01; // Stay in state B
            end else begin
                next_state = 2'b10; // Go to state C
            end
        2'b10: // State C
            if (in) begin
                next_state = 2'b11; // Go to state D
            end else begin
                next_state = 2'b00; // Go to state A
            end
        2'b11: // State D
            if (in) begin
                next_state = 2'b01; // Go to state B
            end else begin
                next_state = 2'b10; // Go to state C
            end
        default:
            next_state = 2'b00; // Default to state A
    endcase

    out = (state == 2'b11); // Output is high when in state D
end

endmodule
