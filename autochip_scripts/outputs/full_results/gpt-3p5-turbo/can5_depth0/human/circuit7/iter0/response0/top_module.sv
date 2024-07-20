module top_module (
    input clk,
    input a,
    output reg q
);

always @(posedge clk) begin
    if (a && q)
        q <= 0;
    else if (a)
        q <= 1;
end

endmodule
