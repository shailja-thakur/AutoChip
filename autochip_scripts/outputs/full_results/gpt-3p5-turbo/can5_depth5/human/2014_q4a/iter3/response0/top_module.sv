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
        Q_next <= Q;
    end else begin // Default behavior
        Q <= 1'b0;
        Q_next <= 1'b0;
    end
end

endmodule
