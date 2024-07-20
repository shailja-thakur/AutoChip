module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

// Intermediate wire
wire M;

// D Flip-Flop
always @(posedge clk) begin
    if (L)  // Load new value
        Q <= R;
    else if (E)  // Shift the register
        Q <= M;
end

// Multiplexer
assign M = (w && E) ? 1'b1 : 1'b0;

endmodule
