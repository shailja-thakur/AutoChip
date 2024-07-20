module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] in_d; // Register to hold the delayed input

    always @(posedge clk) begin
        in_d <= in; // Register the current input to detect changes on the next clock cycle
        pedge <= (~in_d & in); // Detect 0 to 1 transition
    end
endmodule
