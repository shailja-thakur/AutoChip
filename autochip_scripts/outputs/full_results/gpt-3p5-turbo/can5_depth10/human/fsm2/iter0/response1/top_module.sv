module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output out
);

  reg [1:0] state;
  
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b0;
    else begin
      case (state)
        2'b00: begin // OFF
          if (j)
            state <= 2'b01; // Transition to ON state
          else
            state <= 2'b00; // Remain in OFF state
        end
        2'b01: begin // ON
          if (k)
            state <= 2'b00; // Transition to OFF state
          else
            state <= 2'b01; // Remain in ON state
        end
        default: state <= 2'b0;
      endcase
    end
  end
  
  always @(*) begin
    case (state)
      2'b00: out = 1'b0; // OFF
      2'b01: out = 1'b1; // ON
      default: out = 1'b0;
    endcase
  end
  
endmodule
