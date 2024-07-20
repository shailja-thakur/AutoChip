module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] prev_in; // Register to store the previous input value

always @(posedge clk) begin
    // Store the current input value in the previous register
    prev_in <= in;

    // Check for a 0 to 1 transition on each bit and set the corresponding output bit
    pedge <= in & ~prev_in;
end

endmodule
