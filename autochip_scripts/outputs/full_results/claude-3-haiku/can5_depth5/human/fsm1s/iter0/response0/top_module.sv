module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

localparam STATE_A = 1'b0;
localparam STATE_B = 1'b1;

reg current_state, next_state;

always @(posedge clk) begin
    if (reset)
        current_state <= STATE_B;
    else
        current_state <= next_state;
end

always @(*) begin
    case (current_state)
        STATE_A: begin
            out = 1'b0;
            if (in)
                next_state = STATE_A;
            else
                next_state = STATE_B;
        end
        STATE_B: begin
            out = 1'b1;
            if (in)
                next_state = STATE_B;
            else
                next_state = STATE_A;
        end
        default: begin
            out = 1'b0;
            next_state = STATE_B;
        end
    endcase
end

endmodule
