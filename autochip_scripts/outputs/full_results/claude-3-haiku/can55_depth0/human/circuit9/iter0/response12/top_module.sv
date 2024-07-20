module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a && q != 4) begin
        q <= q + 1;
    end
    else if (!a && q == 4) begin
        q <= 0;
    end
end

endmodule
