module top_module (
    input clk,
    input in,
    input reset,
    output out
);

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset)
        state <= 2'b00;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        2'b00: // State A
            if (in == 0)
                next_state = 2'b00;
            else
                next_state = 2'b01;
        2'b01: // State B
            if (in == 0)
                next_state = 2'b10;
            else
                next_state = 2'b01;
        2'b10: // State C
            if (in == 0)
                next_state = 2'b00;
            else
                next_state = 2'b11;
        2'b11: // State D
            if (in == 0)
                next_state = 2'b10;
            else
                next_state = 2'b01;
        default:
            next_state = 2'b00;
    endcase

    out = (state == 2'b11) ? 1'b1 : 1'b0;
end

endmodule
