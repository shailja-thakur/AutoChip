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
        // Compute the next state of each cell
        for (int i = 0; i < 512; i++) begin
            // Compute the next state based on the current cell and its neighbors
            q[i] = ((i > 0 ? q[i-1] : 1'b0) & (q[i]) & (i < 511 ? q[i+1] : 1'b0)) |
                   ((i > 0 ? q[i-1] : 1'b0) & (~q[i]) & (i < 511 ? q[i+1] : 1'b0)) |
                   ((i > 0 ? q[i-1] : 1'b0) & (q[i]) & (~(i < 511 ? q[i+1] : 1'b0))) |
                   ((~(i > 0 ? q[i-1] : 1'b0)) & (q[i]) & (i < 511 ? q[i+1] : 1'b0));
        end
    end
end

endmodule
