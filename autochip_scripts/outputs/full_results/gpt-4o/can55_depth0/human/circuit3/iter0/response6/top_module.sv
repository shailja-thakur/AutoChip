module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output reg q
);
    always @(*) begin
        q = (a & d) | (b & (c | d));
    end
endmodule
