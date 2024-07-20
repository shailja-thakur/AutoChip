module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);
    
    // Define always block triggered on the positive edge of the clock
    always @(posedge clk) begin
        q <= d;
    end
endmodule
