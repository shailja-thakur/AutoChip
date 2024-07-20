module top_module (
    input clk,
    input a,
    output reg q
);

    always @(posedge clk) begin
        if (a)
            q <= ~q;
        else
            q <= 1'b1;
    end

endmodule
