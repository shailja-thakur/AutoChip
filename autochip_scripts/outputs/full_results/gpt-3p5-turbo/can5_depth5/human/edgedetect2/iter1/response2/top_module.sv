module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] prev_in;

initial begin
    prev_in = 8'b0;
end

always @(posedge clk) begin
    anyedge <= (in & ~prev_in);
    prev_in <= in;
end

endmodule
