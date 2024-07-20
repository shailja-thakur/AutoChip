module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    if (a & b)
        state <= 1;
    else if (a & ~b)
        state <= state;
    else if (~a & b)
        state <= 0;
    else
        state <= ~state;
end

always @(posedge clk) begin
    q <= state;
end

endmodule
