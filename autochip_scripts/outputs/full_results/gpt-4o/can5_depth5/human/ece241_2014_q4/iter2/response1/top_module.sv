module top_module (
    input clk,
    input x,
    output z
);

// Intermediate flip-flop outputs
reg q1, q2, q3;

// Combinational logic for XNOR gate output
assign z = ~(q1 ^ q2 ^ q3);

// D flip-flops with outputs feed back to inputs
always @(posedge clk) begin
    q1 <= x ^ q1;
    q2 <= x & ~q2;
    q3 <= x | ~q3;
end

endmodule
