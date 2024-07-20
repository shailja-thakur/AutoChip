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
            q[511:1] <= (q[510:0] & q[511:1] & ~q[512:2]) |
                        (~q[510:0] & q[511:1] & q[512:2]) |
                        (q[510:0] & ~q[511:1] & q[512:2]) |
                        (~q[510:0] & ~q[511:1] & ~q[512:2]);
            q[0] <= 1'b0; // Boundary condition: q[-1] = 0
        end
    end

endmodule
