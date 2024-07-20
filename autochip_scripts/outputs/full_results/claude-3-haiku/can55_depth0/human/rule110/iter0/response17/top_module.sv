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
        // Compute the next state for each cell
        q[511:1] <= (q[510:0] & {511{q[511]}}) | (~q[510:0] & {511{q[1]}}) | ({511{q[0] ^ q[1] ^ q[2]}} & ~q[0]);
        q[0] <= (q[511] & q[0]) | (~q[511] & q[1]) | ({1{q[0] ^ q[1] ^ q[2]}} & ~q[0]);
    end
end

endmodule
