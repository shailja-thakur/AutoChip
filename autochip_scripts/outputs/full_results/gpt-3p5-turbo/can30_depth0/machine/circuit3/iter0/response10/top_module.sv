module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    reg q;

    always @(*) begin
        q = (a | b) & (c | d);
    end
endmodule
