module top_module(
    input a, 
    input b,
    output out
);
    
    always @(*) begin
        out = a & b;
    end
    
endmodule
