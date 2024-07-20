module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    // Set initial value of q to 8'b0
    initial begin
        q = 8'b0;
    end

    // On rising edge of clk, store the data input in the register
    always @(posedge clk) begin
        q <= d;
    end

endmodule
