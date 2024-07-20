module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

localparam STATE_A = 1'b0;
localparam STATE_B = 1'b1;

reg state_reg, state_next;

always @(posedge clk, posedge reset) begin
    if (reset)
        state_reg <= STATE_B;
    else
        state_reg <= state_next;
end

always @(*) begin
    case (state_reg)
        STATE_A: begin
            if (in)
                state_next = STATE_A;
            else
                state_next = STATE_B;
            out = 1'b0;
        end
        STATE_B: begin
            if (in)
                state_next = STATE_B;
            else
                state_next = STATE_A;
            out = 1'b1;
        end
        default: begin
            state_next = STATE_B;
            out = 1'b1;
        end
    endcase
end

endmodule
