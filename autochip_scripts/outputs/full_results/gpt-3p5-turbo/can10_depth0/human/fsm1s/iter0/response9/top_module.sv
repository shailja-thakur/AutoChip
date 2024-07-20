module top_module (
  input clk,
  input in,
  input reset,
  output out
);

  reg [1:0] state;
  
  always @(posedge clk) begin
    if (reset)
      state <= 2'b10; // B
    else begin
      case (state)
        2'b10: // B
          if (in)
            state <= 2'b10; // B
          else
            state <= 2'b01; // A
          
        2'b01: // A
          if (in)
            state <= 2'b01; // A
          else
            state <= 2'b10; // B
      endcase
    end
  end
  
  always @(state) begin
    case (state)
      2'b10: // B
        out <= 1'b1;
      2'b01: // A
        out <= 1'b0;
    endcase
  end
  
endmodule
