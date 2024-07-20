module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);
    reg tmp;

    always @(posedge clk) begin
        if (E) begin
            if (L)
                tmp <= R;
            else
                tmp <= Q;
        end else begin
            tmp <= Q;
        end
        
        if (L)
            Q <= tmp;
        else if (w)
            Q <= w;
    end
endmodule
