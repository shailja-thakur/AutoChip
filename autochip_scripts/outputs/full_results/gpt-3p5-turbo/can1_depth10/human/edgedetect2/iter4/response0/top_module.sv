module top_module(
    input wire clk,
    input wire [7:0] in,
    output reg [7:0] anyedge
);

    reg [7:0] in_prev;
    reg anyedge_reg;

    always @(posedge clk) begin
        in_prev <= in;
        anyedge_reg <= (in & ~in_prev);
    end

    always @(posedge clk) begin
        anyedge <= anyedge_reg;
    end

endmodule
