module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

reg t;

always @(posedge clk) begin
    if (E) begin
        if (L) begin
            Q <= R;
        end else begin
            Q <= t;
            t <= Q;
        end
    end else if (L) begin
        Q <= R;
    end else begin
        Q <= t;
        t <= Q;
    end
end

assign t = w;

endmodule
