module top_module (
    input clk,
    input a,
    output reg q
);

    always @(posedge clk) begin
        if (a == 0)
            q <= 1;
        else
            q <= ~q;
    end

endmodule
