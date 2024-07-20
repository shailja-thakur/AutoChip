module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg q_next, state_next;

always @(posedge clk) begin
    case(state)
        0: begin
            if (a == b)
                state_next = 1;
            else
                state_next = 0;
            q_next = 0;
        end
        1: begin
            if (a == b)
                state_next = 0;
            else
                state_next = 1;
            q_next = 1;
        end
    endcase
end

always @(posedge clk) begin
    state <= state_next;
    q <= q_next;
end

endmodule
