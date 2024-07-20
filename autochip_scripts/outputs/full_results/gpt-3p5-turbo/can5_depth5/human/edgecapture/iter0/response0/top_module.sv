module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);

reg [31:0] old_in;

always @(posedge clk) begin
    if (reset)
        old_in <= 32'b0;
    else begin
        old_in <= in;
        out <= old_in & (~in);
    end
end

endmodule
