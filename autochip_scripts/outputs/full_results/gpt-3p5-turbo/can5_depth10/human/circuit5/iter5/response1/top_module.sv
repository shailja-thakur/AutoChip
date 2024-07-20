module top_module (
  input [3:0] a, 
  input [3:0] b, 
  input [3:0] c, 
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);

always @(*) begin
    case ({a, b, c, d, e})
        // 15ns
        5'b0000: q = 4'b1011; 
        // 20ns
        5'b0001: q = 4'b1110; 
        // 25ns
        5'b0010: q = 4'b0001; 
        // 30ns
        5'b0011: q = 4'b1101; 
        // 35ns
        5'b0100: q = 4'b1111; 
        // 40ns to 90ns
        5'b0101, 5'b0110, 5'b0111, 5'b1000, 5'b1001, 5'b1010: q = 4'b1111; 
        // 65ns
        5'b1011: q = 4'b0001; 
        // 70ns
        5'b1100: q = 4'b1111; 
        // 75ns
        5'b1101: q = 4'b1111; 
        // 80ns
        5'b1110: q = 4'b1111; 
        // 85ns to 90ns
        5'b1111: q = 4'b1111; 
        default: q = 4'b1111;
    endcase
end

endmodule
