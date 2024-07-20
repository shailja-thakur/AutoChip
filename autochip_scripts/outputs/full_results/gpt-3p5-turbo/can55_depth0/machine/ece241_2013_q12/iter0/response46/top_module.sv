module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg [7:0] q,
    output reg Z
);

reg [7:0] q_next;

always @(posedge clk) begin
    if (enable) begin
        q_next <= S & {q[6:0], A}; // Shift q and include A at the LSB position
    end else begin
        q_next <= q;
    end
end

assign Z = q_next[{A, B, C}];

always @(posedge clk) begin
    if (enable) begin
        q <= q_next;
    end
end

endmodule
