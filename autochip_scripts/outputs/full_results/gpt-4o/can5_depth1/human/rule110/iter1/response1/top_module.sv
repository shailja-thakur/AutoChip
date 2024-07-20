module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // Create a temporary array to hold the next state
            reg [511:0] next_q;
            
            // Assume the boundaries (q[-1] and q[512]) are both zero (off)
            next_q[0] <= (q[1]); // q[-1] is 0, so this reduces to q[1]
            
            // For the remaining cells
            for (integer i = 1; i < 511; i = i + 1) begin
                next_q[i] <= (q[i-1] & q[i] & ~q[i+1]) | // Case: 110
                             (q[i-1] & ~q[i] & q[i+1]) | // Case: 101
                             (~q[i-1] & q[i] & q[i+1]) | // Case: 011
                             (q[i-1] & q[i] & q[i+1]) | // Case: 111
                             (q[i-1] & ~q[i] & ~q[i+1]) | // Case: 100
                             (~q[i-1] & q[i] & ~q[i+1]) | // Case: 010
                             (~q[i-1] & ~q[i] & q[i+1]); // Case: 001
            end
            
            // Special case for the last element, assuming q[512] is 0
            next_q[511] <= (q[510]); // q[512] is 0, so this reduces to q[510]
            
            // Update the state
            q <= next_q;
        end
    end
endmodule
