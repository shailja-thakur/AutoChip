module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @ (posedge clk) begin
    if (R) begin
        Q <= 0;
    end else if (E) begin
        if (L) begin
            Q <= R;
        end else begin
            Q <= w;
        end
    end
end

endmodule
