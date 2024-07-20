module top_module (
  input clk,
  input in,
  input areset,
  output out
);

  reg [1:0] state, next_state;
  reg out_reg;
  
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;
  
  // Moore state machine logic
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= A;
    end else begin
      state <= next_state;
    end
  end
  
  // Output assignment
  always @(state) begin
    case (state)
      A: begin
        out_reg = 1'b0;
        if (in) begin
          next_state = B;
        end else begin
          next_state = A;
        end
      end
      
      B: begin
        out_reg = 1'b0;
        if (in) begin
          next_state = B;
        end else begin
          next_state = C;
        end
      end
      
      C: begin
        out_reg = 1'b0;
        if (in) begin
          next_state = D;
        end else begin
          next_state = A;
        end
      end
      
      D: begin
        out_reg = 1'b1;
        if (in) begin
          next_state = B;
        end else begin
          next_state = C;
        end
      end
    endcase
  end
  
  // Assign output
  always @(posedge clk) begin
    out <= out_reg;
  end
  
endmodule
