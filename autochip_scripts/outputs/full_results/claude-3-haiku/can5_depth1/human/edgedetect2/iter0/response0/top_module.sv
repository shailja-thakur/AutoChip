module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] prev_in;

always @(posedge clk) begin
    // Store the previous input value
    prev_in <= in;

    // Detect any edge and set the output bit
    anyedge <= (in ^ prev_in);
end

endmodule
