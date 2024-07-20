module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    if (a && b)
        state <= ~state;
    else
        state <= state;
end

always @(posedge clk) begin
    if (a && !b)
        q <= 1'b1;
    else if (!a && b)
        q <= 1'b0;
    else
        q <= q;
end

endmodule
