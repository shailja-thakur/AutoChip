module top_module(
    input p1a, 
    input p1b, 
    input p1c, 
    input p1d, 
    output p1y, 
    input p2a, 
    input p2b, 
    input p2c, 
    input p2d, 
    output p2y
);
    wire p1n; // intermediate wire for p1y output
    wire p2n; // intermediate wire for p2y output
    
    // 4-input AND gate for p1y output
    assign p1n = ~(p1a & p1b & p1c & p1d);
    
    // 4-input AND gate for p2y output
    assign p2n = ~(p2a & p2b & p2c & p2d);
    
    // Inverter for p1y output
    assign p1y = ~p1n;
    
    // Inverter for p2y output
    assign p2y = ~p2n;
    
endmodule
