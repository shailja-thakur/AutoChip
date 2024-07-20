module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    wire [3:0] inputs;
    wire result;
    wire inv_result;
    
    assign inputs = {a, b, c, d};
    assign result = ^inputs;
    assign inv_result = ~result;
    assign q = inv_result;

endmodule
