module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b00; // State A
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        2'b00: // State A
            if (in == 1'b0)
                next_state = 2'b00; // Stay in State A
            else
                next_state = 2'b01; // Transition to State B
        2'b01: // State B
            if (in == 1'b0)
                next_state = 2'b10; // Transition to State C
            else
                next_state = 2'b01; // Stay in State B
        2'b10: // State C
            if (in == 1'b0)
                next_state = 2'b00; // Transition to State A
            else
                next_state = 2'b11; // Transition to State D
        2'b11: // State D
            if (in == 1'b0)
                next_state = 2'b10; // Transition to State C
            else
                next_state = 2'b01; // Transition to State B
        default:
            next_state = 2'b00; // Default to State A
    endcase
end

assign out = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
