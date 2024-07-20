module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    if (a == 1 && b == 1)
        state <= ~state;
    else if (a == 1 && b == 0)
        state <= state;
    else if (a == 0 && b == 1)
        state <= 1'b1;
    else
        state <= 1'b0;
end

always @(posedge clk) begin
    q <= state;
end

endmodule
