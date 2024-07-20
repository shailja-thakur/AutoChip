module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] prev_in;

    always @(posedge clk) begin
        // Compare current input with previous input to detect positive edge
        pedge <= (~prev_in & in);
        // Update previous input with current input
        prev_in <= in;
    end

endmodule
