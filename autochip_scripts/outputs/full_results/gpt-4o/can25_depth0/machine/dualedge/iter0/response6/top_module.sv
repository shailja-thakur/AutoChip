module top_module(
    input clk,
    input d,
    output reg q
);

reg qp, qn;

// Update registers based on the clock edge
always @(posedge clk)
    qp <= d;

always @(negedge clk)
    qn <= d;

// Assign output based on the clock signal
always @(clk or qp or qn)
    if (clk)
        q <= qp;
    else
        q <= qn;

endmodule
