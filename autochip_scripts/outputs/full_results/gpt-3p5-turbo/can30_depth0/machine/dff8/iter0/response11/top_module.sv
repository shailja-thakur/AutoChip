module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);
 
    // initialize output
    initial begin
        q = 8'b0;
    end
 
    // store data input in register on rising edge of clock
    always @(posedge clk) begin
        q <= d;
    end
 
endmodule
