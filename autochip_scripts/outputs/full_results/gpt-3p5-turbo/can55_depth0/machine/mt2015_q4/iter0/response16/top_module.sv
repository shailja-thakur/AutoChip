module top_module(
    input x,
    input y,
    output z
);
	
    wire a, b;
    
    andGate g1 (.a(x), .b(y), .z(a));
    andGate g2 (.a(y), .b(x), .z(b));
    orGate g3 (.a(a), .b(b), .z(z));
    
endmodule
module andGate(
    input a,
    input b,
    output z
);
    
    assign z = a & b;
    
endmodule
module orGate(
    input a,
    input b,
    output z
);
    
    assign z = a | b;
    
endmodule
