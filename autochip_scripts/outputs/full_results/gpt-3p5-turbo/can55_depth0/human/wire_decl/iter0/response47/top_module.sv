module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );
    
    wire intermediate_1;
    wire intermediate_2;
    
    // First layer: two AND gates
    and_gate and1 (a, b, intermediate_1);
    and_gate and2 (c, d, intermediate_2);
    
    // Second layer: OR gate
    or_gate or1 (intermediate_1, intermediate_2, out);
    
    // Inverted output
    not_gate not1 (out, out_n);
    
    // AND gate module
    module and_gate (
        input a,
        input b,
        output out );
        
        assign out = a & b;
        
    endmodule
module or_gate (
        input a,
        input b,
        output out );
        
        assign out = a | b;
        
    endmodule
module not_gate (
        input a,
        output out );
        
        assign out = ~a;
        
    endmodule
