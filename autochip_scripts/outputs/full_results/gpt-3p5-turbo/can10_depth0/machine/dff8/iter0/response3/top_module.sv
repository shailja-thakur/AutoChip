module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);
    
    initial begin
        q = 8'h0; // Set the default value of q to 8'h0
    end
    
    always @(posedge clk) begin
        q <= d; // Store the data input in the register and output on q
    end
endmodule
