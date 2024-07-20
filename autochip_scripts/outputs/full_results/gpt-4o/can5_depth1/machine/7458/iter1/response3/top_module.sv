module top_module(
    input p1a, 
    input p1b, 
    input p1c, 
    input p1d,
    input p1e,
    input p1f,
    output p1y, 
    input p2a, 
    input p2b, 
    input p2c, 
    input p2d, 
    output p2y
);

    // Define internal wires for intermediate signals
    wire and1_result;
    wire or1_result;
    
    // Calculate intermediate signals
    assign and1_result = p1a & p1b & p1c;
    assign or1_result = p1d | p1e | p1f;
    
    // Calculate p1y
    assign p1y = and1_result | or1_result;

    // Calculate p2y directly
    assign p2y = (p2a & p2b) | (p2c | p2d);

endmodule
