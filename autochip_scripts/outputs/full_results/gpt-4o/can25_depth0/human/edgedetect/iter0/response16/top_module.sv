module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

    reg [7:0] in_d;

    always @(posedge clk) begin
        in_d <= in;                // Capture the input state at each clock cycle
        pedge <= in & ~in_d;       // Detect the positive edge for each bit
    end

endmodule
