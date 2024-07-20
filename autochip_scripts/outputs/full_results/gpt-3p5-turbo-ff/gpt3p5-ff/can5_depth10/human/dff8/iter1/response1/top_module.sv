module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    reg [7:0] q_temp;
    reg [7:0] q_reg;

    always @(posedge clk) begin
        q_temp <= d;
    end

    always @(negedge clk) begin
        q_reg <= q_temp;
    end

    assign q = q_reg;

endmodule
