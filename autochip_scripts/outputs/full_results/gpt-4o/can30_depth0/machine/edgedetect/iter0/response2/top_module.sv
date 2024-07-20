module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] d_last;

    always @(posedge clk) begin
        // Compute rising edge detection
        pedge <= in & ~d_last;
        // Store current input value for next cycle
        d_last <= in;
    end

endmodule
