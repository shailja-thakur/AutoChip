module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_q;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Compute the next state for each cell (Rule 110)
            next_q[0] <= q[1]; // Boundary: q[-1] is assumed to be 0
            next_q[511] <= q[510]; // Boundary: q[512] is assumed to be 0
            for (int i = 1; i < 511; i = i + 1) begin
                next_q[i] <= (q[i-1] & ~q[i] & q[i+1]) | // 1 0 1
                             (q[i-1] & q[i] & ~q[i+1]) | // 1 1 0
                             (~q[i-1] & q[i] & q[i+1]) | // 0 1 1
                             (q[i] & ~q[i+1]) | // x 1 0
                             (~q[i-1] & q[i]) | // 0 1 x
                             (q[i+1] & ~q[i-1]) | // 0 x 1
                             (q[i-1] & q[i]) | // 1 x x
                             (q[i+1] & q[i+1]); // x x 1
            end
            q <= next_q;
        end
    end
endmodule
