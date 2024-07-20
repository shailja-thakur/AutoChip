module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

reg [1:0] Q_next;

always @(posedge clk) begin
    if (L) begin // Load value
        Q <= R;
        Q_next <= {1'b0, R};
    end else if (E) begin // Enable shift
        Q <= Q_next[1];
        Q_next <= {Q_next[0], w};
    end
end

endmodule
