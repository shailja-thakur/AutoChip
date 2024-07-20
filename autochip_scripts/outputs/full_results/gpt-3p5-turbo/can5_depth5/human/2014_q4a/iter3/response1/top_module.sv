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
    if (reset) begin // Reset value
        Q <= 2'b00;
        Q_next <= 2'b00;
    end else if (L) begin // Load value
        Q <= R;
        Q_next <= R;
    end else if (E) begin // Enable shift
        Q <= Q_next;
        Q_next <= Q;
    end
end

endmodule
