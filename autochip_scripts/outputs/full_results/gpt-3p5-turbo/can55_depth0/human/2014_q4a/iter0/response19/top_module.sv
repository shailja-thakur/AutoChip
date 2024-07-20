module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

reg D;

always @(posedge clk)
begin
    if (E)
    begin
        D <= R;
        if (L)
            Q <= D;
        else
            Q <= Q;
    end
    else
    begin
        D <= Q;
        Q <= w;
    end
end

endmodule
