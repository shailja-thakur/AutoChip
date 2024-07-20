module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

    reg [7:0] previous_in;

    always @(posedge clk) begin
        previous_in <= in;
        pedge <= in & ~previous_in;
    end

endmodule
