module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] in_d1; // Delayed input signal

always @(posedge clk) begin
    in_d1 <= in; // Store the previous input signal

    // Detect the 0 to 1 transition for each bit
    pedge <= in & ~in_d1;
end

endmodule
