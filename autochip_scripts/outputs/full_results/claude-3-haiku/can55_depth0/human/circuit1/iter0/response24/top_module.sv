module top_module (
    input a, 
    input b, 
    output q
);

always @(*) begin
    q = (a & b) | (~a & ~b);
end

endmodule
