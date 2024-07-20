module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);

    always @(posedge clk)
        if (j && !Q)
            Q <= j;
        else if (!k && Q)
            Q <= 0;
        else if (j && k)
            Q <= ~Q;
        else
            Q <= Q;

endmodule
