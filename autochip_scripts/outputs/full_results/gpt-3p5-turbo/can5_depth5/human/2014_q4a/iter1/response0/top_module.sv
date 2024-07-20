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
        Q <= R;
    end else if (E) begin // Enable shift
        Q <= Q_next;
    end
end

always @(clk) begin
    if (w) begin // Input to first stage
        Q_next <= R;
    end else begin
        Q_next <= Q;
    end
end

endmodule
