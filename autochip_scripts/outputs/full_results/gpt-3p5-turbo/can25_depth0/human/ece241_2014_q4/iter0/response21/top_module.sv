module top_module (
    input clk,
    input x,
    output z
);

reg d1, d2, d3;
wire d1_complement, d2_complement, d3_complement;

assign d1_complement = ~d1;
assign d2_complement = ~d2;
assign d3_complement = ~d3;

always @(posedge clk) begin
    d1 <= d1_complement;
    d2 <= d2_complement;
    d3 <= d3_complement;
end

xor gate1 (x, d1, d1_fb);
and gate2 (x, d2, d2_fb);
or gate3 (x, d3, d3_fb);
xnor gate4 (d1_complement, d2_complement, d3_complement, z);

endmodule
module xor (input a, input b, output y);
    assign y = a ^ b;
endmodule
module and (input a, input b, output y);
    assign y = a & b;
endmodule
module or (input a, input b, output y);
    assign y = a | b;
endmodule
module xnor (input a, input b, input c, output y);
    assign y = ~(a ^ b ^ c);
endmodule
