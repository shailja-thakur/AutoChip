module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

// Define internal signals for intermediate calculations
reg q_next;

// D-flip-flop
always @(posedge clk) begin
    if (L)
        Q <= R;
    else if (E)
        Q <= q_next;
end

// MUX
always @* begin
    if (E)
        q_next = w;
    else
        q_next = Q;
end

endmodule
