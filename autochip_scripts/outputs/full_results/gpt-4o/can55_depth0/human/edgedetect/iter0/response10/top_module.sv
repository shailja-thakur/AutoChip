module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] prev;

    always @(posedge clk) begin
        prev <= in;               // Store previous state of 'in'
        pedge <= (~prev) & in;    // Detect positive edge for each bit
    end

endmodule
