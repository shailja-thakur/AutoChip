module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    if (a && b)
        state <= 0;
    else if (a)
        state <= ~state;
    else if (b)
        state <= 1;
    else
        state <= state;
    q <= state;
end

endmodule
