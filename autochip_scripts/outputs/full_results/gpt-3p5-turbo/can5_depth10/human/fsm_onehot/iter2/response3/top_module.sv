module top_module (
  input in,
  input [9:0] state,
  output [9:0] next_state,
  output out1,
  output out2);
  
  // Define internal wires/regs
  reg S0, S1, S2, S3, S4, S5, S6, S7, S8, S9;
  
  // Assign next_state[9:0] based on state[9:0] and in
  always @(*) begin
    case (state)
      10'b 111_111_110:
        next_state = 10'b 110_000_000;
      10'b 111_111_111:
        next_state = 10'b 100_000_001;
      10'b 110_000_000:
        next_state = 10'b 111_111_110;
      10'b 100_000_001:
        next_state = 10'b 001_000_010;
      10'b 111_111_010:
        next_state = 10'b 110_000_000;
      10'b 111_111_011:
        next_state = 10'b 001_000_010;
      10'b 111_000_010:
        next_state = 10'b 110_000_000;
      10'b 111_000_011:
        next_state = 10'b 010_000_011;
      10'b 111_000_100:
        next_state = 10'b 110_000_000;
      10'b 111_000_101:
        next_state = 10'b 100_000_001;
      default:
        next_state = 10'b 111_111_110;
    endcase
  end
  
  // Assign out1
  always @(posedge in) begin
    case (state)
      10'b 111_000_010:
        out1 = 1'b 0;
      10'b 111_000_011:
        out1 = 1'b 1;
      10'b 111_000_110:
        out1 = 1'b 0;
      10'b 111_000_111:
        out1 = 1'b 1;
      default:
        out1 = 1'b 0;
    endcase
  end

  // Assign out2
  always @(posedge in) begin
    case (state)
      10'b 111_000_110:
        out2 = 1'b 0;
      10'b 111_000_111:
        out2 = 1'b 1;
      default:
        out2 = 1'b 0;
    endcase
  end
  
endmodule
