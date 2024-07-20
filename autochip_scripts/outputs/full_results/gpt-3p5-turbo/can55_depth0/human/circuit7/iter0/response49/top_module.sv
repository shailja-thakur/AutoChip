module top_module (
    input clk,
    input a,
    output reg q
);

always @(posedge clk) begin
    if (a == 1) begin
        if (q == 0)
            q <= 1;
        else
            q <= 0;
    end
end

endmodule
