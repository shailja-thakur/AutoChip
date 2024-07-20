module top_module (
    input wire clk,
    input wire j,
    input wire k,
    output reg Q
);

always @(posedge clk) begin
    if (j && ~k) // changed ~Q to ~k
        Q <= j;
    else if (~j && k) // changed ~k to ~j
        Q <= 0;
    else if (j && k)
        Q <= ~Q;
end

endmodule
