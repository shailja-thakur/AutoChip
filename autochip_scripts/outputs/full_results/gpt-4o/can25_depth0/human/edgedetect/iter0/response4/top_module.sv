module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        pedge <= (in & ~prev_in); // Detect 0 to 1 transition
        prev_in <= in;
    end

endmodule
