module top_module (
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

    reg [7:0] d_last;

    always @(posedge clk) begin
        pedge <= in & ~d_last;
        d_last <= in;
    end

endmodule
