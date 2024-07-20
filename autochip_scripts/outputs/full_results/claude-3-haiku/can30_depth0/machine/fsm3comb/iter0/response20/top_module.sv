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
                next_state = 2'b01; // Transition to State B
            end else begin
                next_state = 2'b00; // Stay in State A
            end
        2'b01: // State B
            if (in) begin
                next_state = 2'b01; // Stay in State B
            end else begin
                next_state = 2'b10; // Transition to State C
            end
        2'b10: // State C
            if (in) begin
                next_state = 2'b11; // Transition to State D
            end else begin
                next_state = 2'b00; // Transition to State A
            end
        2'b11: // State D
            if (in) begin
                next_state = 2'b01; // Transition to State B
            end else begin
                next_state = 2'b10; // Transition to State C
            end
        default:
            next_state = 2'b00; // Default to State A
    endcase

    // Assign the 'out' signal to be high when the state machine is in State D
    out = (state == 2'b11) ? 1'b1 : 1'b0;
end

endmodule
