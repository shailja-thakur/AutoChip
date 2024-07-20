module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
    
    integer i;
    
    always @(posedge clk) begin
        if (load)
            q <= data;
        else begin
            reg [511:0] next_q;
            next_q[0] = 0 ^ q[1]; // boundaries are off
            next_q[511] = q[510] ^ 0;
            for (i = 1; i < 511; i = i + 1) begin
                next_q[i] = q[i-1] ^ q[i+1];
            end
            q <= next_q;
        end
    end
    
endmodule
