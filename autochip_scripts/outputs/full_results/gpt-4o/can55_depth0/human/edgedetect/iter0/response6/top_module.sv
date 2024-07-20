module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        pedge <= ~prev_in & in; // Detect positive edge for each bit
        prev_in <= in;          // Update previous input state
    end

endmodule
