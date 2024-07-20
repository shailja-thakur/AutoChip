module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b00; // State A
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        2'b00: // State A
            if (in == 1'b0)
                next_state = 2'b00; // State A
            else
                next_state = 2'b01; // State B
        2'b01: // State B
            if (in == 1'b0)
                next_state = 2'b10; // State C
            else
                next_state = 2'b01; // State B
        2'b10: // State C
            if (in == 1'b0)
                next_state = 2'b00; // State A
            else
                next_state = 2'b11; // State D
        2'b11: // State D
            if (in == 1'b0)
                next_state = 2'b10; // State C
            else
                next_state = 2'b01; // State B
        default:
            next_state = 2'b00; // State A
    endcase
end

always @(*) begin
    case (state)
        2'b00, 2'b01, 2'b10: // States A, B, C
            out = 1'b0;
        2'b11: // State D
            out = 1'b1;
        default:
            out = 1'b0;
    endcase
end

endmodule
