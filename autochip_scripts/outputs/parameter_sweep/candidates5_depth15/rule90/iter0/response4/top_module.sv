module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
    
    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q[0] <= data[0] ^ q[1] ^ q[512];
      
            for (int i = 1; i < 511; i = i + 1) begin
                q[i] <= q[i-1] ^ q[i+1] ^ q[i+512];
            end
            
            q[512] <= q[512-1] ^ q[0] ^ q[512];
        end
    end
    
endmodule
