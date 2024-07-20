module top_module (
    input clk,
    input d,
    output reg q
);

reg q1, q2;

always @(posedge clk) begin
    q1 <= d; // Capture input on positive edge
end

always @(negedge clk) begin
    q2 <= q1; // Capture input from q1 on negative edge
end

always @(posedge clk) begin
    q <= q2; // Capture input from q2 on positive edge
end

endmodule
