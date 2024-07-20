module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

reg FF_out;

always @(posedge clk) begin
    if (E) begin
        if (L) begin
            FF_out <= R;
        end else begin
            FF_out <= w;
        end
    end
end

always @(posedge clk) begin
    if (E) begin
        Q <= FF_out;
    end
end

endmodule
