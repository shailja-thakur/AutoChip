module top_module(
    input wire clk,
    input wire [7:0] in,
    output reg [7:0] anyedge
);

    reg [7:0] prev_cycle;

    always @(posedge clk) begin
        prev_cycle <= in;
        anyedge <= (in ^ prev_cycle) & in;
    end

endmodule
