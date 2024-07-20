module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [512:0] q);

    always @(posedge clk) begin
        if (load) begin
            q[511:0] <= data;
        end else begin
            q[0] <= 1'b0; // Set q[0] to 0 (zero)
            for (int i = 1; i < 512; i = i + 1) begin
                q[i] <= q[i-1] ^ q[i+1];
            end
        end
    end
    
endmodule
