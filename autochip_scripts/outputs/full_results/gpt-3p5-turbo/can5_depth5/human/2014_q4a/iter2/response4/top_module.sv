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

always @(posedge clk) begin
    Q_next <= Q; // Default assignment to preserve value

    if (L) begin // Load value
        Q_next <= R;
    end else if (E) begin // Enable shift
        Q_next <= w ? Q_next >> 1 : Q_next; // Perform shift if w is true
    end
end

endmodule
