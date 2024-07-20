module top_module (
    input clk,
    input j,
    input k,
    output reg Q
);
    always @(posedge clk) begin
        if (j & ~k)
            Q <= ~Q;
        else if (~j & k)
            Q <= Q;
    end
endmodule
