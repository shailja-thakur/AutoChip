module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    reg [7:0] d_reg;

    always @(posedge clk) begin
        d_reg <= d;
    end

    assign q = d_reg;

endmodule
