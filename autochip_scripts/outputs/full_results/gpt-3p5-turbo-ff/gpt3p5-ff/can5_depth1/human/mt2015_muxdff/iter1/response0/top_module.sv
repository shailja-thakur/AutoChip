module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

// Submodule: Flip Flop
reg q_ff;

always @(posedge clk) begin
    if (L) begin
        q_ff <= r_in;
    end else begin
        q_ff <= q_ff;
    end
end

// Submodule: 2-1 MUX
reg Q_mux;

always @(L or q_ff or q_in) begin
    if (L) begin
        Q_mux <= r_in;
    end else begin
        Q_mux <= q_ff;
    end
end

// Output Q
always @(posedge clk) begin
    Q <= q_ff;
end

endmodule
