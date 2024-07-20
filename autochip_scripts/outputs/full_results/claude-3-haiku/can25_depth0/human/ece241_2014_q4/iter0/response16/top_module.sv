module top_module (
    input clk,
    input x,
    output z
);

// Declare the D flip-flop registers
reg q1, q2, q3;

// Combinational logic for gate inputs
wire xor_in = x ^ q1;
wire and_in = x & ~q2;
wire or_in = x | ~q3;

// D flip-flop logic
always @(posedge clk) begin
    q1 <= xor_in;
    q2 <= and_in;
    q3 <= or_in;
end

// 3-input XNOR gate for output
assign z = ~(q1 ^ q2 ^ q3);

endmodule
