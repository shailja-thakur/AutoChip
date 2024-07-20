module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);
    
    always @(posedge clk) begin
        if (load)
            q <= data;
        else begin
            q <= q >> 1;  // Shift q to the right
        end
    end
endmodule
