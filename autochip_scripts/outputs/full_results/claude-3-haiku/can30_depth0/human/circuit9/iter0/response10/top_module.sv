module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a) begin
        if (q < 4)
            q <= q + 1;
        else
            q <= 0;
    end
    else begin
        q <= q;
    end
end

endmodule
