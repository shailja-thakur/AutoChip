module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output out
);

  parameter OFF = 1'b0;
  parameter ON = 1'b1;
  
  reg [1:0] state, next_state;
  
  always@(posedge clk) begin
    if (areset) begin
      state <= OFF;
    end else begin
      state <= next_state;
    end
  end
  
  always@(state, j, k) begin
    case(state)
      OFF: begin
        if (j) begin
          next_state = ON;
        end else begin
          next_state = OFF;
        end
        out = OFF;
      end
      
      ON: begin
        if (k) begin
          next_state = OFF;
        end else begin
          next_state = ON;
        end
        out = ON;
      end
    endcase
  end

endmodule
