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
        if (L) begin
            Q <= R;
        end
        else begin
            Q <= w;
        end
    end
    else begin
        // Retain previous value of Q when E is low
        Q <= Q;
    end
end

endmodule
