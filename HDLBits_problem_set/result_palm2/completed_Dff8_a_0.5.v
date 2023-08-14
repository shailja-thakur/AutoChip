module top_module (
    input clk,
    input [7:0] d,
    output [7:0] q
);

    reg [7:0] q;
    reg [7:0] d_reg;

    always @(posedge clk) begin
        q <= d_reg;
        d_reg <= d;
    end

endmodule