module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] in_d; // Register to store the delayed input

    always @(posedge clk) begin
        in_d <= in;              // Capture the input on the rising edge of the clock
        pedge <= (~in_d & in);   // Detect positive edge (0 to 1 transition)
    end

endmodule
