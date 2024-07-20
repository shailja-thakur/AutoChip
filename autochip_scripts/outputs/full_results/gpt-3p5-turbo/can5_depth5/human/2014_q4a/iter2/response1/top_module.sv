module top_module (
  input clk,
  input w,
  input R,
  input E,
  input L,
  output reg Q
);

reg [25:0] Q_next; // Increase width of Q_next register

always @(posedge clk) begin
  if (L) begin
    Q_next <= R; // Move the assignment to the Q_next register inside if condition
  end else if (E) begin
    Q_next <= Q << 1; // Shift Q by one bit when enabling shift
  end
end

always @(posedge clk) begin
  if (w) begin
    Q <= R;
  end else begin
    Q <= Q_next; // Assign Q_next to Q outside if condition
  end
end

endmodule
