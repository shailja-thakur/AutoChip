module top_module(
    input clk,
    input load,
    input [1:0] ena,
    input [99:0] data,
    output reg [99:0] q);
  
    always @(posedge clk) begin
        if (load) // Load data into q
            q <= data;
        else if (ena == 2'h1) // Shift left
            q <= q << 1;
        else if (ena == 2'h2) // Shift right
            q <= q >> 1;
    end
endmodule
