module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    // Initialize the output to default value
    initial begin
        q = 8'h0;
    end

    // Edge triggered always block 
    always @(posedge clk) begin
        q <= d;
    end
endmodule
