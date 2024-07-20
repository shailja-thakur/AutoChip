module top_module (
    input in,
    input [9:0] state,
    output [9:0] next_state,
    output out1,
    output out2);
  
  // State transition logic
  always @(state or in) begin
    case(state)
      10'b01_000_000: next_state = 10'b01_000_000; // S0 (0, 0) --0--> S0
      10'b01_000_000: next_state = 10'b01_000_001; // S0 (0, 0) --1--> S1
      10'b01_000_001: next_state = 10'b01_000_000; // S1 (0, 0) --0--> S0
      10'b01_000_001: next_state = 10'b01_000_010; // S1 (0, 0) --1--> S2
      10'b01_000_010: next_state = 10'b01_000_000; // S2 (0, 0) --0--> S0
      10'b01_000_010: next_state = 10'b01_000_011; // S2 (0, 0) --1--> S3
      10'b01_000_011: next_state = 10'b01_000_000; // S3 (0, 0) --0--> S0
      10'b01_000_011: next_state = 10'b01_000_100; // S3 (0, 0) --1--> S4
      10'b01_000_100: next_state = 10'b01_000_000; // S4 (0, 0) --0--> S0
      10'b01_000_100: next_state = 10'b01_000_101; // S4 (0, 0) --1--> S5
      10'b01_000_101: next_state = 10'b01_000_000; // S5 (0, 0) --0--> S0
      10'b01_000_101: next_state = 10'b01_000_110; // S5 (0, 0) --1--> S6
      10'b01_000_110: next_state = 10'b01_000_111; // S6 (0, 0) --0--> S9
      10'b01_000_110: next_state = 10'b01_001_000; // S6 (0, 0) --1--> S7
      10'b01_001_000: next_state = 10'b01_000_000; // S7 (0, 1) --0--> S0
      10'b01_001_000: next_state = 10'b01_001_000; // S7 (0, 1) --1--> S7
      10'b01_000_111: next_state = 10'b01_000_000; // S8 (1, 0) --0--> S0
      10'b01_000_111: next_state = 10'b01_000_001; // S8 (1, 0) --1--> S1
      10'b01_001_000: next_state = 10'b01_000_000; // S9 (1, 1) --0--> S0
      10'b01_001_000: next_state = 10'b01_000_001; // S9 (1, 1) --1--> S1
      default: next_state = 10'b01_000_000;
    endcase
  end
  
  // Output logic
  always @(state) begin
    case(state)
      10'b01_000_000: begin out1 = 1'b0; out2 = 1'b0; end
      10'b01_001_000: begin out1 = 1'b0; out2 = 1'b0; end
      10'b01_000_001: begin out1 = 1'b0; out2 = 1'b0; end
      10'b01_000_010: begin out1 = 1'b0; out2 = 1'b0; end
      10'b01_000_011: begin out1 = 1'b0; out2 = 1'b0; end
      10'b01_001_000: begin out1 = 1'b0; out2 = 1'b1; end
      10'b01_000_100: begin out1 = 1'b0; out2 = 1'b0; end
      10'b01_000_101: begin out1 = 1'b0; out2 = 1'b0; end
      10'b01_000_110: begin out1 = 1'b0; out2 = 1'b0; end
      10'b01_000_111: begin out1 = 1'b1; out2 = 1'b0; end
      10'b01_001_000: begin out1 = 1'b1; out2 = 1'b1; end
      default: begin out1 = 1'b0; out2 = 1'b0; end
    endcase
  end
  
endmodule
