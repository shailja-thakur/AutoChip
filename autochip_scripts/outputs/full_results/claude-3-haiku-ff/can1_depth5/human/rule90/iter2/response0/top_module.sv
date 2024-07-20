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
        // Calculate the next state of each cell using the rule
        q[511] <= q[510] ^ q[0];
        q[510:1] <= q[509:0] ^ q[511:1];
        q[0] <= q[1] ^ 1'b0; // Special case for the leftmost cell
    end
end

endmodule
