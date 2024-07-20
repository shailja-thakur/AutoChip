module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] prev_in;

always @(posedge clk) begin
    // Detect any edge transition from 0 to 1
    anyedge <= (in & ~prev_in);
    prev_in <= in;
end

endmodule
