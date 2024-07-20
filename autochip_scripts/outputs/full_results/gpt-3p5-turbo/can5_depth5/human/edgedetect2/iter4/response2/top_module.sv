module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] prev_in;

always @(posedge clk) begin
    prev_in <= in;
end

always @(posedge clk) begin
    if (in != prev_in) begin
        anyedge <= in;
    end
end

endmodule
