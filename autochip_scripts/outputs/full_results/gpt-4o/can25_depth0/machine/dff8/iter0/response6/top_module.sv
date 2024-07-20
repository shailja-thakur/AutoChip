module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    initial begin
        q = 8'h0; // Default value for output
    end

    always @(posedge clk) begin
        q <= d; // Store data input in register and output it
    end
endmodule
