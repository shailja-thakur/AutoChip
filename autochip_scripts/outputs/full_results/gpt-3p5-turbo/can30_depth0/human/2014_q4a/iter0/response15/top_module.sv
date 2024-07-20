module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);
    reg d;

    always @(posedge clk) begin
        if (E)
            d <= w;
        else if (L)
            d <= R;
    end

    always @(posedge clk) begin
        if (L)
            Q <= R;
        else
            Q <= d;
    end
endmodule
