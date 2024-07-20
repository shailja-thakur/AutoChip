module top_module(
    input clk,
    input d,
    output reg q
);

    reg qp; // Positive clock edge register
    reg qn; // Negative clock edge register

    always @(posedge clk)
        qp <= d;

    always @(negedge clk)
        qn <= d;

    always @(posedge clk or negedge clk)
        if (clk)
            q <= qp;
        else
            q <= qn;

endmodule
