module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    // Initialize the output to 0
    initial begin
        q = 8'h0;
    end

    // On the rising edge of the clock, store the input data in the register
    always @(posedge clk) begin
        q <= d;
    end
    
endmodule
