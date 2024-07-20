module top_module (
  input [3:0] a, 
  input [3:0] b, 
  input [3:0] c, 
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);

always @(*) begin
    // Implement the logic based on the simulation waveforms provided
    case({a,b,c,d,e})
        5'b00000, 5'b00001, 5'b00010, 5'b01111: q = 4'b1111;
        5'b00011: q = b;
        5'b00100: q = e;
        5'b00101: q = b;
        5'b00110: q = a;
        5'b00111: q = d;
        5'b01000: q = e;
        5'b01001: q = a;
        5'b01010: q = e;
        5'b01011: q = a;
        5'b01100: q = a;
        5'b01101: q = d;
        5'b01110: q = f;
        default: q = 4'b1111;
    endcase
end

endmodule
