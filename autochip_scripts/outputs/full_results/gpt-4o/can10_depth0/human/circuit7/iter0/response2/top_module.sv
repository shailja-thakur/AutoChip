module top_module (
    input clk,
    input a, 
    output reg q
);

    always @(posedge clk) begin
        if (a == 1)
            q <= ~q; // on the positive edge of clk, toggle q if a is 1
        else
            q <= q;  // if a is not 1, keep q unchanged
    end

endmodule
