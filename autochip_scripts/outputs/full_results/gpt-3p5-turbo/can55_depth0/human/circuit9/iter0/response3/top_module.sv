module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a) begin
        if (q == 0)
            q <= 4;
        else if (q == 4)
            q <= 5;
        else if (q == 5)
            q <= 6;
        else if (q == 6)
            q <= 0;
    end else begin
        if (q == 0)
            q <= 0;
        else if (q == 1)
            q <= 1;
    end
end

endmodule
