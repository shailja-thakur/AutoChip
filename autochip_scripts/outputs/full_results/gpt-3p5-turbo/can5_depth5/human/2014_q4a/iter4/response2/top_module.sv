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
        Q_next <= R;
    end else if (E) begin // Enable shift
        Q <= Q_next;
        Q_next <= w;
    end else begin // Disable shift
        Q <= Q_next;
        Q_next <= Q_next;
    end
end

endmodule
