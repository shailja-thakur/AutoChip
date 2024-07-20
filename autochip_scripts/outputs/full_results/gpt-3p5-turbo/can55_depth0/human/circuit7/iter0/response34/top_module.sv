module top_module (
    input clk,
    input a,
    output reg q
);

// D flip-flop
always @(posedge clk) begin
    q <= a;
end

endmodule
