module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output reg out
);
  reg [1:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00; // OFF state
      out <= 1'b0; // out is 0 in OFF state
    end else begin
      case(state)
        2'b00: begin // OFF state
          if (j) begin
            state <= 2'b01; // Transition to ON state if j is 1
            out <= 1'b0; // out is 0 in OFF state
          end else begin
            state <= 2'b00; // Stay in OFF state if j is 0
            out <= 1'b0; // out is 0 in OFF state
          end
        end
        
        2'b01: begin // ON state
          if (k) begin
            state <= 2'b00; // Transition to OFF state if k is 1
            out <= 1'b1; // out is 1 in ON state
          end else begin
            state <= 2'b01; // Stay in ON state if k is 0
            out <= 1'b1; // out is 1 in ON state
          end
        end
      endcase
    end
  end
endmodule
