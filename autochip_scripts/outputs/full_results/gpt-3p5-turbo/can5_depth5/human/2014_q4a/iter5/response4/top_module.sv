module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

reg Q_next;

always @(posedge clk) begin
    if (L) begin // Load value
        Q_next <= R;
    end else if (E) begin // Enable shift
        Q_next <= Q;
    end else begin // Default case
        Q_next <= Q;
    end
end

always @(posedge clk) begin
    Q <= Q_next;
end

endmodule
