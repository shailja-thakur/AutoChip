module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);
 
 reg D;
 
 // Register flip-flop
 always @(posedge clk) begin
     if (L)
         D <= R;
     else if (E)
         D <= w;
 end
 
 // Multiplexer
 always @(posedge clk) begin
     if (E)
         Q <= D;
 end
 
endmodule
