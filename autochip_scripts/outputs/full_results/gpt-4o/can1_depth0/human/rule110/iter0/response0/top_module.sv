module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    // Internal register to store the next state
    reg [511:0] next_q;
    
    always @(*) begin
        // Compute the next state based on Rule 110
        integer i;
        for (i = 0; i <= 511; i = i + 1) begin
            if (i == 0) begin
                // For the first cell, assume q[-1] is 0
                next_q[i] = (q[511] & q[i] & q[i+1]) |
                           (q[511] & ~q[i] & q[i+1]) |
                           (q[511] & ~q[i] & ~q[i+1]) |
                           (~q[511] & q[i] & ~q[i+1]);
            end else if (i == 511) begin
                // For the last cell, assume q[512] is 0
                next_q[i] = (q[i-1] & q[i] & 0) |
                           (q[i-1] & ~q[i] & 0) |
                           (q[i-1] & ~q[i] & q[0]) |
                           (~q[i-1] & q[i] & q[0]);
            end else begin
                next_q[i] = (q[i-1] & q[i] & q[i+1]) |
                           (q[i-1] & ~q[i] & q[i+1]) |
                           (q[i-1] & ~q[i] & ~q[i+1]) |
                           (~q[i-1] & q[i] & ~q[i+1]);
            end
        end
    end
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q <= next_q;
        end
    end
endmodule
