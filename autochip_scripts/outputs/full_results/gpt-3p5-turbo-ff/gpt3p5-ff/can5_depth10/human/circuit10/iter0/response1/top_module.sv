module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg q_next;

always @(posedge clk) begin
    if (state == 0 && a == 1 && b == 0)
        q_next = 1;
    else if (state == 1 && a == 1 && b == 0)
        q_next = 0;
    else if (state == 1 && a == 0 && b == 1)
        q_next = 1;
    else
        q_next = q;
end

always @(posedge clk) begin
    state <= q_next;
end

assign q = q_next;

endmodule
