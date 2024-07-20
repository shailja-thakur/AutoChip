module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] prev_cycle;

always @(posedge clk) begin
    prev_cycle <= in;
end

always @(posedge clk) begin
    anyedge <= (in & ~prev_cycle);
end

// Reset anyedge to 0 at the start of simulation
initial begin
    anyedge <= 8'b0;
end

endmodule
