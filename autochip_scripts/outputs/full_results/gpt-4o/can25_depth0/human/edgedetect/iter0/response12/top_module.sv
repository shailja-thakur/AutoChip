module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] in_d; // Register to store the delayed input signal

always @(posedge clk) begin
    // Detect positive edge for each bit in the 8-bit vector
    pedge <= (~in_d) & in;
    // Store the current input for the next cycle
    in_d <= in;
end

endmodule
