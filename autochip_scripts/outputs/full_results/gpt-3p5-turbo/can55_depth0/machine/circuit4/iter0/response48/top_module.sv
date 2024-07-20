module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    
    // OR gate that produces output q
    assign q = b | c;
    
endmodule
