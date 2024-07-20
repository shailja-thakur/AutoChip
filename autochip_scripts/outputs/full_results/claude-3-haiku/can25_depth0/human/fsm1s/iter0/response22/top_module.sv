module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

localparam STATE_A = 1'b0;
localparam STATE_B = 1'b1;

reg state_reg, state_next;

always @(posedge clk) begin
    if (reset)
        state_reg <= STATE_B;
    else
        state_reg <= state_next;
end

always @(*) begin
    case (state_reg)
        STATE_B: begin
            out = 1'b1;
            if (in)
                state_next = STATE_B;
            else
                state_next = STATE_A;
        end
        STATE_A: begin
            out = 1'b0;
            if (in)
                state_next = STATE_A;
            else
                state_next = STATE_B;
        end
        default: begin
            out = 1'b0;
            state_next = STATE_B;
        end
    endcase
end

endmodule
