module top_module (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);
  
  always @* begin
    case (sel)
      0: out = in[3:0];
      1: out = in[7:4];
      2: out = in[11:8];
      // Add more cases for all possible values of sel
      
      default: out = 4'b0; // Default case, when sel is not in the defined range
    endcase
  end

endmodule
