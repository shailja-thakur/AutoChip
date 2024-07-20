module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            reg [511:0] next_q;
            integer i;
            for (i = 0; i < 512; i = i + 1) begin
                if (i == 0) begin
                    // Boundary condition q[-1] = 0, q[0], q[1]
                    next_q[i] <= (0 & q[i] & q[i+1]) | (0 & q[i] & ~q[i+1]) |
                                 (0 & ~q[i] & q[i+1]) | (~0 & q[i] & q[i+1]) |
                                 (~0 & q[i] & ~q[i+1]);
                end else if (i == 511) begin
                    // Boundary condition q[511], q[512] = 0
                    next_q[i] <= (q[i-1] & q[i] & 0) | (q[i-1] & q[i] & ~0) |
                                 (q[i-1] & ~q[i] & 0) | (~q[i-1] & q[i] & 0) |
                                 (~q[i-1] & q[i] & ~0);
                end else begin
                    // General case
                    next_q[i] <= (q[i-1] & q[i] & q[i+1]) | (q[i-1] & q[i] & ~q[i+1]) |
                                 (q[i-1] & ~q[i] & q[i+1]) | (~q[i-1] & q[i] & q[i+1]) |
                                 (~q[i-1] & q[i] & ~q[i+1]);
                end
            end
            q <= next_q;
        end
    end

endmodule
