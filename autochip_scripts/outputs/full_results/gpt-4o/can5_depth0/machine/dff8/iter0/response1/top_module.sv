module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    // Initial block to set the output to a default value of 8'h0
    initial begin
        q = 8'h0;
    end

    // Always block to store the data input on the rising edge of the clock
    always @(posedge clk) begin
        q <= d;
    end

endmodule
