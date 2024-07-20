module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a) begin
        if (q == 4)
            q <= 4;
        else
            q <= q + 1;
    end
    else begin
        if (q == 0)
            q <= 1;
        else if (q == 6)
            q <= 0;
        else
            q <= q;
    end
end

endmodule
