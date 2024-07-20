module top_module (
    input clk,
    input a,
    output reg q
);

always @(posedge clk) begin
    if (a == 1) begin
        q <= ~q;  // Toggle q on every positive edge of clk when a is 1
    end else begin
        q <= q;  // Maintain the value of q when a is 0
    end
end

endmodule
