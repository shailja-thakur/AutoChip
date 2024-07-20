module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a == 1'b1)
        q <= 3'b100; // q is set to 4 when a is 1
    else if (q == 3'b110)
        q <= 3'b000; // q is set to 0 when a is 0 and q is 6
    else
        q <= q + 1; // q is increased by 1 when a is 0 and q is not 6
end

endmodule
