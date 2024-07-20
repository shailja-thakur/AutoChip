module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
    
    always @(posedge clk) begin
        if (load)
            q <= data;
        else begin
            q[511] <= (q[510] & q[509]);
            q[510] <= (q[510] & ~q[509]) | (q[509] & ~q[508]) | (q[509] & q[508]);
            
            for (i = 509; i > 1; i = i-1) begin
                q[i] <= (q[i] & ~q[i-1]) | (q[i-1] & q[i-2]) | (q[i-1] & ~q[i-2]) | (q[i-1] & q[i] & ~q[i-2]);
            end
            
            q[1] <= (q[1] & ~q[0]) | (q[0] & q[511]) | (q[0] & ~q[511]);
            q[0] <= (q[0] & ~q[511]) | (q[511] & q[510]);
        end
    end
    
endmodule
