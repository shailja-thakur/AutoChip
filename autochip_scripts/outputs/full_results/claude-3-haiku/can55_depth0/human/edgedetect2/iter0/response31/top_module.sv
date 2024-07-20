module top_module(
    input clk,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] in_prev;

always @(posedge clk) begin
    // Store the previous input value
    in_prev <= in;

    // Detect any edge (0 to 1 or 1 to 0) and set the output
    anyedge <= (in ^ in_prev);
end

endmodule
