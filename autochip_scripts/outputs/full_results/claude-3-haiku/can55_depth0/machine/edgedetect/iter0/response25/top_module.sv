module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

    reg [7:0] d_last;

    always @(posedge clk) begin
        d_last <= in; // Store the current input value in d_last
        pedge <= in & ~d_last; // Calculate the rising edge signal
    end

endmodule
