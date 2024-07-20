module top_module (
    input clk,
    input x,
    output reg z
);

reg dFF1, dFF2, dFF3;

always @(posedge clk)
begin
    dFF1 <= x ^ dFF1;
    dFF2 <= ~dFF2 & x;
    dFF3 <= ~dFF3 | x;
    
    z <= ~(dFF1 ^ dFF2 ^ dFF3);
end

endmodule
