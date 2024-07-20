module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);
    always @(posedge clk) begin
        if (L)
            Q <= R;
        else if (E)
            Q <= w;
    end
endmodule
