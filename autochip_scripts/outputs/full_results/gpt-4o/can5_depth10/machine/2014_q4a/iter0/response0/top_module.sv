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
        if (R)
            Q <= 1'b0;
        else if (E)
        begin
            if (L)
                Q <= R;
            else
                Q <= w;
        end
    end
endmodule
