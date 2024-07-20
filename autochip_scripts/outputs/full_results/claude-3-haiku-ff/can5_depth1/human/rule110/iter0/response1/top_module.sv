module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else begin
        // Compute the next state of the cells
        q[511:1] <= (q[510:0] & q[511:1] & ~q[512:2]) |
                   (q[510:0] & ~q[511:1] & q[512:2]) |
                   (~q[510:0] & q[511:1] & q[512:2]) |
                   (~q[510:0] & ~q[511:1] & ~q[512:2]);
        q[0] <= (q[-1] & q[0] & ~q[1]) | (q[-1] & ~q[0] & q[1]) | (~q[-1] & q[0] & q[1]) | (~q[-1] & ~q[0] & ~q[1]);
    end
end

endmodule
