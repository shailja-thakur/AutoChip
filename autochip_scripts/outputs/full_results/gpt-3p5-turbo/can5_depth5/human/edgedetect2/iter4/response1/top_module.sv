module top_module(
    input clk,
    input async_reset,
    input [7:0] in,
    output reg [7:0] anyedge
);

reg [7:0] prev_in;

always @(posedge clk, posedge async_reset) begin
    if (async_reset) begin
        prev_in <= 8'b0;    // Reset the previous value to 0
    end else begin
        prev_in <= in;
    end
end

always @(posedge clk) begin
    anyedge <= in & ~prev_in;
end

endmodule
