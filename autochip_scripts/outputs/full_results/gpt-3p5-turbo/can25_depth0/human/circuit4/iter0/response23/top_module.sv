module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    
    // Declare internal wire connections
    wire w1, w2, w3, w4, w5, w6;

    // Define the combinational logic
    assign w1 = ~(a & b);
    assign w2 = ~(c & d);
    assign w3 = w1 & w2;
    assign w4 = ~(a & c);
    assign w5 = ~(b & d);
    assign w6 = w4 & w5;
    assign q = w3 | w6;
    
endmodule
