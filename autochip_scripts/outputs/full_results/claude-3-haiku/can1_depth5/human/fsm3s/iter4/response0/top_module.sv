module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 2'b00; // State A
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        2'b00: // State A
            if (in)
                next_state = 2'b01; // State B
            else
                next_state = 2'b00; // State A
        2'b01: // State B
            if (in)
                next_state = 2'b11; // State D
            else
                next_state = 2'b10; // State C
        2'b10: // State C
            if (in)
                next_state = 2'b11; // State D
            else
                next_state = 2'b00; // State A
        2'b11: // State D
            if (in)
                next_state = 2'b01; // State B
            else
                next_state = 2'b10; // State C
        default:
            next_state = 2'b00; // State A
    endcase
end

always @(*) begin
    case (state)
        2'b00, 2'b01, 2'b10:
            out = 1'b0;
        2'b11:
            out = 1'b1;
        default:
            out = 1'b0;
    endcase
end

endmodule
