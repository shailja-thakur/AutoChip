module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk) begin
    if (E) begin
        if (L)
            Q <= R;
        else if (Q == 1'b1)
            Q <= w;
        else
            Q <= Q;
    end
    else if (L)
        Q <= w;
end

endmodule
