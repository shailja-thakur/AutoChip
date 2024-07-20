module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= 2'b00;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        2'b00: // State A
            if (in)
                next_state = 2'b01; // B
            else
                next_state = 2'b00; // A
        2'b01: // State B
            if (in)
                next_state = 2'b01; // B
            else
                next_state = 2'b10; // C
        2'b10: // State C
            if (in)
                next_state = 2'b11; // D
            else
                next_state = 2'b00; // A
        2'b11: // State D
            if (in)
                next_state = 2'b01; // B
            else
                next_state = 2'b10; // C
        default:
            next_state = 2'b00; // A
    endcase

    out = (state == 2'b11); // Output is high when in state D
end

endmodule
