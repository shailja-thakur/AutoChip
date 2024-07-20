module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q
);

    initial begin
        q <= 8'h0; // set the output to a default value of 8'h0
    end
    
    always @(posedge clk) begin
        q <= d; // store the data input in the register
    end
    
endmodule
