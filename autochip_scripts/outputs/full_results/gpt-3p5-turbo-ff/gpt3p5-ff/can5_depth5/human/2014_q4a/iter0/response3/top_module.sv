module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

wire q_next;

always @(posedge clk) begin
    if (L) begin
        Q <= R;
    end else if (E) begin
        Q <= q_next;
    end
end

assign q_next = (L) ? R : (E) ? w : Q;

endmodule
