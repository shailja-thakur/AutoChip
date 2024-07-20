module top_module (
    input clk,
    input x,
    output reg z);
    
    reg d1, d2, d3;
    wire xor_out, and_out, or_out;
    
    xor_gate xor1(
        .a(d1),
        .b(d1),
        .out(xor_out)
    );
    
    and_gate and1(
        .a(d2),
        .b(~d2),
        .out(and_out)
    );
    
    or_gate or1(
        .a(d3),
        .b(~d3),
        .out(or_out)
    );
    
    xnor_gate xnor1(
        .a(xor_out),
        .b(and_out),
        .c(or_out),
        .out(z)
    );
    
    always @(posedge clk) begin
        d1 <= x ^ d1;
        d2 <= x & ~d2;
        d3 <= x | ~d3;
    end
    
endmodule
module xor_gate(output a, input b, input c);
    assign a = b ^ c;
endmodule
module and_gate(output a, input b, input c);
    assign a = b & c;
endmodule
module or_gate(output a, input b, input c);
    assign a = b | c;
endmodule
module xnor_gate(output a, input b, input c, input d);
    assign a = ~(b ^ c ^ d);
endmodule
