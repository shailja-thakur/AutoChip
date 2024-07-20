module top_module (
  input [3:0] a, 
  input [3:0] b, 
  input [3:0] c, 
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);

always @(*) begin
    case({c,d,e})
        3'b001: q = b;
        3'b010: q = d;
        3'b011: q = e;
        3'b100: q = a;
        default: q = 4'b0000; // Set default value to all zeros
    endcase
end

endmodule
