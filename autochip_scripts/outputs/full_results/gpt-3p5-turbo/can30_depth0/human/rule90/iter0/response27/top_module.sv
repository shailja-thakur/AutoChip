module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
        
    integer i;

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            // boundary cells
            q[0] = q[1] ^ 0;
            q[511] = q[510] ^ 0;
            
            // remaining cells
            for (i = 1; i <= 510; i = i + 1) begin
                q[i] = q[i-1] ^ q[i+1];
            end
        end
    end
endmodule
