module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] in_d;

    always @(posedge clk) begin
        // Detect positive edge for each bit in the input vector
        pedge <= (in & ~in_d);
        // Store previous state of the input vector
        in_d <= in;
    end

endmodule
