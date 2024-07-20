module top_module(
    input x,
    input y,
    output z);
    
    // Define internal wire
    wire w1;
    wire w2;
    
    // Define intermediate wire
    wire w3;
    
    // Assign output z
    assign z = w3;
    
    // Define and gates
    and gate1(w1, x, y);
    and gate2(w2, x, y);
    
    // Define or gate
    or gate3(w3, w1, w2);
    
endmodule
