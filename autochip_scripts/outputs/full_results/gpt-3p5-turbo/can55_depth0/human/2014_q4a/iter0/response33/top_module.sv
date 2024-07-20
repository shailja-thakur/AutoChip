module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

reg d;     // Data input to the flip-flop

// Load the value on positive clock edge when L is asserted
always @(posedge clk) begin
   if (L) begin
      d <= R;
   end else if (E) begin
      d <= w;
   end
end

// Output Q of the flip-flop
always @(posedge clk) begin
   if (E) begin
      Q <= d;
   end
end

endmodule
