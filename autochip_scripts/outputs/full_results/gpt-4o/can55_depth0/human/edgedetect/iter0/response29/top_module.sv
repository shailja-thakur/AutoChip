module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge);

    reg [7:0] in_d; // Register to store the value of 'in' from the previous cycle

    always @(posedge clk) begin
        pedge <= (~in_d) & in; // Detect positive edge for each bit and set the corresponding output bit
        in_d <= in;           // Store the current value of 'in' for the next cycle
    end

endmodule
