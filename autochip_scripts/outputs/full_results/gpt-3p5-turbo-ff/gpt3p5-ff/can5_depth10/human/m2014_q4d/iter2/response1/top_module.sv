module top_module (
    input clk,
    input in,
    output logic out
);

logic d;

always @(posedge clk) begin
    d <= in ^ out;
    out <= d;
end

// Add initial value to the flip-flop
initial begin
    d <= 0;
    out <= 0;
end

endmodule
