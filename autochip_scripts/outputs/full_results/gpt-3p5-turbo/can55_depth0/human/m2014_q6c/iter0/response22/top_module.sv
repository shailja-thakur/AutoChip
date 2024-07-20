module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

  wire A, B, C, D, E, F;
  
  assign A = (y == 6'b000001);
  assign B = (y == 6'b000010);
  assign C = (y == 6'b000100);
  assign D = (y == 6'b001000);
  assign E = (y == 6'b010000);
  assign F = (y == 6'b100000);

  assign Y2 = (~w & (A | D)) | (w & (C | F));
  assign Y4 = ~w & (B | E);

endmodule
