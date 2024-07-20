module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);

always @(posedge clk)
    if (j && ~k)
        Q <= 1'b1;
    else if (~j && k)
        Q <= 1'b0;
    else if (j && k)
        Q <= ~Q;
    // else case for j = 0 and k = 0 is not required as the output will be Qold

endmodule
