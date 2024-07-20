module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q[511] <= q[510] ^ 1'b0; // Set q[512] to 0 (zero)
            for (int i = 0; i < 511; i = i + 1) begin
                q[i] <= q[i-1] ^ q[i+1];
            end
        end
    end
    
endmodule
