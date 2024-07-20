module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);

always @(posedge clk) begin
    if (load)
        q <= data;
    else begin
        // Handle first cell
        q[0] <= q[1];
        // Handle internal cells
        for (int i = 1; i < 511; i++) begin
            q[i] <= q[i-1] ^ q[i+1];
        end
        // Handle last cell
        q[511] <= 0;
    end
end

endmodule
