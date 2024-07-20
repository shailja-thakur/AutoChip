module top_module(
    input clk,
    input d,
    output reg q
);

    reg qp, qn;

    always @(posedge clk) begin
        qp <= d;
    end

    always @(negedge clk) begin
        qn <= d;
    end

    always @(clk) begin
        if (clk)
            q <= qp;
        else
            q <= qn;
    end

endmodule
