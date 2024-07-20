module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk) begin
    if (R) 
        Q <= 0;
    else if (E)
        Q <= L ? R : w;
end

endmodule
