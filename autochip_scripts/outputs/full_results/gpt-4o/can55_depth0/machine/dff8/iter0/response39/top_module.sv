module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    // Initialize the output with default value 8'h0
    initial begin
        q = 8'h00;
    end

    // On the rising edge of the clock, store the data input in the register and output it
    always @(posedge clk) begin
        q <= d;
    end

endmodule
