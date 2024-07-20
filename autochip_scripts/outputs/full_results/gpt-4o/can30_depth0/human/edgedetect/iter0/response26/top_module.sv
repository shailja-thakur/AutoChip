module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] in_delayed;

    always @(posedge clk) begin
        pedge <= (~in_delayed) & in; // Detect positive edge
        in_delayed <= in; // Update delayed version of in
    end

endmodule
