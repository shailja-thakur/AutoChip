module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        pedge <= (~prev_in & in); // Detecting positive edge
        prev_in <= in; // Storing the current state of the input
    end

endmodule
