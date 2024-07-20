module top_module (
  input clk,
  input in,
  input reset,
  output out
);

  reg [1:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b0;
    end else begin
      case (state)
        2'b00: begin // B state
          if (in) begin
            state <= 2'b00; // Remain in B state
          end else begin
            state <= 2'b01; // Transition to A state
          end
        end
        2'b01: begin // A state
          if (in) begin
            state <= 2'b01; // Remain in A state
          end else begin
            state <= 2'b00; // Transition to B state
          end
        end
      endcase
    end
  end
  
  always @(state) begin
    case (state)
      2'b00: begin // B state
        out = 1'b1;
      end
      2'b01: begin // A state
        out = 1'b0;
      end
    endcase
  end
endmodule
