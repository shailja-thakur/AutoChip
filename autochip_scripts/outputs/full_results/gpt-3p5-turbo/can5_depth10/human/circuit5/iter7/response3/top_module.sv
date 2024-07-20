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
    case({c,d,e})
        3'b000: q = b;
        3'b001: q = e;
        3'b010: q = a;
        3'b011: q = d;
        default: q = 4'b1111;
    endcase
end

endmodule
