module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] d_last;

    always @(posedge clk) begin
        // Calculate rising edge detection
        pedge <= in & ~d_last;
        // Update d_last with current input
        d_last <= in;
    end

endmodule
