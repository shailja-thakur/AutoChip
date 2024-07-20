module top_module (
    input a, 
    input b, 
    output reg q
);

always @(*) begin
    q = a & b;
end

endmodule
