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
        // Advance the state of the cellular automaton by one time step
        q[0] <= (q[511] & q[0]) | (~q[511] & q[1]) | (q[1] & ~q[511]);
        q[511:1] <= q[510:0];
    end
end

endmodule
