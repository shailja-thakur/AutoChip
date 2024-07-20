module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge);

    reg [7:0] in_reg;

    // Detect any edge on input signals
    always @(posedge clk) begin
        anyedge <= (in_reg ^ in) & in;
        in_reg <= in;
    end

endmodule
