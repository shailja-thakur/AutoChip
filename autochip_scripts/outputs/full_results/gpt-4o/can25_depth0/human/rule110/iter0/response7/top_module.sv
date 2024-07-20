module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q
);
    
    wire [511:0] next;

    integer i;
    
    // Compute the next state for each cell in next
    always @* begin
        next[0] = (q[0] & ~q[1]) | (~q[0] & q[1]); // Left boundary
        next[511] = (q[510] & q[511]) | (q[510] & ~q[511]) | (~q[510] & q[511]); // Right boundary

        for (i = 1; i < 511; i = i + 1) begin
            next[i] = (q[i-1] & q[i]) | (q[i-1] & ~q[i+1]) | (~q[i-1] & q[i+1]);
        end
    end
    
    // Assign the next state to q on each clock edge, with support for loading new data
    always @(posedge clk) begin
        if (load) 
            q <= data;
        else 
            q <= next;
    end

endmodule
