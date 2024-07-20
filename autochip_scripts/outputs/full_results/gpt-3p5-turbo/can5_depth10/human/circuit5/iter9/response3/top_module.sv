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
        3'b000: q = 4'b0100; // cde is 0 0 0
        3'b001: q = e; // cde is 0 0 1
        3'b010: q = a; // cde is 0 1 0
        3'b011: q = d; // cde is 0 1 1
        3'b100: q = b; // cde is 1 0 0
        default: q = 4'b1111;
    endcase
end

endmodule
