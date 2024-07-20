module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk)
begin
    if (E)
    begin
        if (L)
            Q <= R;
        else
            Q <= Q;
    end
    else
    begin
        Q <= w;
    end
end

endmodule
