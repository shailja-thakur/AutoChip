module top_module(
    input clk,
    input d,
    output reg q
);

    reg d_ff1, d_ff2;

    always @(posedge clk) begin
        d_ff1 <= d;
        d_ff2 <= d_ff1;
    end

    always @(*) begin
        if (clk == 1'b0 && d_ff1 != d_ff2)
            q <= d_ff1;
        else if (clk == 1'b1 && d_ff1 != d_ff2)
            q <= d_ff2;
    end

endmodule
