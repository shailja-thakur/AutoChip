module top_module (
    input clk,
    input x,
    output z
);

reg q1, q2, q3;

// D flip-flops
always @(posedge clk) begin
    q1 <= x;
    q2 <= x;
    q3 <= x;
end

// Three-input XNOR gate
assign z = ~(q1 ^ ~q2 ^ q3);

endmodule
