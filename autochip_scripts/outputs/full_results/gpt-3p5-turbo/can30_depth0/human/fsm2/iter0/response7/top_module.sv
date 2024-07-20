module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output reg out
);
  reg [1:0] state;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 2'b00; // OFF state
      out <= 1'b0;
    end
    else begin
      case (state)
        2'b00: begin // OFF state
          if (j) begin
            state <= 2'b01; // Transition to ON state
            out <= 1'b0;
          end 
          else begin
            state <= 2'b00; // Stay in OFF state
            out <= 1'b0;
          end
        end
        
        2'b01: begin // ON state
          if (k) begin
            state <= 2'b00; // Transition to OFF state
            out <= 1'b1;
          end 
          else begin
            state <= 2'b01; // Stay in ON state
            out <= 1'b1;
          end
        end
      endcase
    end
  end
  
endmodule
