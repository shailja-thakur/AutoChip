module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

initial 
    q = 3'bXXX;

always @(posedge clk) begin
    if (a) 
        q <= 3'b100;
    else 
        q <= q + 1;
end

endmodule
