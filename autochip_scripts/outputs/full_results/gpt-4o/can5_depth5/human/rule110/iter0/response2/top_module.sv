module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    // Temporary register to hold new state of q
    reg [511:0] next_q;

    // Always block to handle the synchronous load of data
    always @(posedge clk) begin
        if (load) begin
            q <= data;  // Load the data if load signal is high
        end else begin
            // Compute the next state for each cell
            next_q[0] = (0 & q[0] & q[1]) | (0 & ~q[0] & q[1]) | (~0 & q[0] & q[1]) | (0 & q[0] & ~q[1]);
            next_q[511] = (q[510] & q[511] & 0) | (q[510] & ~q[511] & 0) | (~q[510] & q[511] & 0) | (q[510] & q[511] & 0);
            
            for (int i = 1; i < 511; i = i + 1) begin
                next_q[i] = (q[i-1] & q[i] & q[i+1]) |
                            (q[i-1] & ~q[i] & q[i+1]) |
                            (~q[i-1] & q[i] & q[i+1]) |
                            (q[i-1] & q[i] & ~q[i+1]);
            end

            // Update q with the computed next state
            q <= next_q;
        end
    end

endmodule
