module top_module(
    input a, 
    input b,
    output out
);
    reg temp;
    
    always @(a or b) begin
        temp = a | b;
        out = ~temp;
    end
endmodule
