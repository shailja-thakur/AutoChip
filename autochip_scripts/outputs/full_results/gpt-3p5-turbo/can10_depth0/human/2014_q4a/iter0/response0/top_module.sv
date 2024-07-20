module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

reg next_Q;

always @(posedge clk) begin
    if (L) begin
        Q <= R;
    end else if (E) begin
        Q <= next_Q;
    end
end

always @* begin
    if (E) begin
        next_Q = w;
    end else begin
        next_Q = Q;
    end
end

endmodule
