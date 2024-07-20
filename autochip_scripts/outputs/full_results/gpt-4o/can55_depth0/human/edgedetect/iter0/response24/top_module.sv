module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] in_delayed;

    always @(posedge clk) begin
        in_delayed <= in; // Store the previous state of 'in'
        pedge <= (~in_delayed & in); // Detect positive edge and set 'pedge' accordingly
    end

endmodule
