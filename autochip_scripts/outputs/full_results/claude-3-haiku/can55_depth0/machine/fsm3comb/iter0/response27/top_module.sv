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
                next_state = 2'b01; // Go to State B
            end else begin
                next_state = 2'b00; // Remain in State A
            end
        2'b01: // State B
            if (in) begin
                next_state = 2'b01; // Remain in State B
            end else begin
                next_state = 2'b10; // Go to State C
            end
        2'b10: // State C
            if (in) begin
                next_state = 2'b11; // Go to State D
            end else begin
                next_state = 2'b00; // Go to State A
            end
        2'b11: // State D
            if (in) begin
                next_state = 2'b01; // Go to State B
            end else begin
                next_state = 2'b10; // Go to State C
            end
        default:
            next_state = 2'b00; // Default to State A
    endcase

    out = (state == 2'b11); // Set output high when in State D
end

endmodule
