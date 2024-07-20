module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    reg [511:0] next_q;

    always @(posedge clk) begin
        if (load)
            q <= data;
        else begin
            next_q[0] = 0 ^ (q[0] & q[1]);  // Handle left boundary separately
            next_q[511] = q[510] ^ (q[511] | q[511]);  // Handle right boundary separately
            
            // Iterate over all cells
            // Handle general case for cells 1 through 510
            for (int i = 1; i < 511; i = i + 1) begin
                next_q[i] = (q[i-1] & q[i] & q[i+1]) ? 0 :
                            (q[i-1] & q[i] & ~q[i+1]) ? 1 :
                            (q[i-1] & ~q[i] & q[i+1]) ? 1 :
                            (~q[i-1] & q[i] & q[i+1]) ? 1 :
                            (~q[i-1] & q[i] & ~q[i+1]) ? 1 :
                            (~q[i-1] & ~q[i] & q[i+1]) ? 1 :
                            0;
            end
            
            q <= next_q;
        end
    end
endmodule
