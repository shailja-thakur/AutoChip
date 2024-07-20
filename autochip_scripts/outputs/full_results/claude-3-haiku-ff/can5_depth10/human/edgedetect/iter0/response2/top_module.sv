module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

reg [7:0] in_prev; // Register to store the previous input value

always @(posedge clk) begin
    // Store the current input value in in_prev
    in_prev <= in;

    // Detect the 0 to 1 transition and set the corresponding output bit
    pedge <= (in & ~in_prev);
end

endmodule
