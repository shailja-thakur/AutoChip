module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk) begin
    if (R) begin
        Q <= 1'b0;
    end else if (E) begin
        if (L) begin
            Q <= R;
        end else begin
            Q <= w;
        end
    end
    // When E is low, Q retains its value implicitly due to not entering any if conditions.
end

endmodule
