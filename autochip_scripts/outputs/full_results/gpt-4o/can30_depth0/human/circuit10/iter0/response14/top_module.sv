module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        state <= q;
        if (a == 1 && b == 1)
            q <= ~q;
        else if (a == 1 && b == 0)
            q <= q;
        else if (a == 0 && b == 1)
            q <= q;
        else
            q <= q;
    end

endmodule
