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
                next_state = 2'b01; // Move to state B
            end else begin
                next_state = 2'b00; // Remain in state A
            end
        2'b01: // State B
            if (in) begin
                next_state = 2'b01; // Remain in state B
            end else begin
                next_state = 2'b10; // Move to state C
            end
        2'b10: // State C
            if (in) begin
                next_state = 2'b11; // Move to state D
            end else begin
                next_state = 2'b00; // Move to state A
            end
        2'b11: // State D
            if (in) begin
                next_state = 2'b01; // Move to state B
            end else begin
                next_state = 2'b10; // Move to state C
            end
    endcase

    // Assign the 'out' signal based on the current state
    out = (state == 2'b11); // 'out' is high when in state D
end

endmodule
