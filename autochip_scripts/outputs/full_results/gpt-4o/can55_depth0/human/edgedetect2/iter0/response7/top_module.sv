module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        prev_in <= in;  // Store the previous input on each clock edge
        anyedge <= (in ^ prev_in) & in;  // Detect edge and set bit after 0 to 1 transition
    end
endmodule
