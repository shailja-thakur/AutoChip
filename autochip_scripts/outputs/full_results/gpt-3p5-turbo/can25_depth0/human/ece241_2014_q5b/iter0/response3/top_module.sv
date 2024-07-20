module top_module (
  input clk,
  input areset,
  input x,
  output z
);

  reg [1:0] state;
  
  // State encoding
  parameter A = 2'b00;
  parameter B = 2'b01;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= A; // Reset into state A
    end else begin
      case(state)
        A: begin
          if (x) begin
            state <= B;
          end else begin
            state <= A;
          end
        end
        B: begin
          if (x) begin
            state <= B;
          end else begin
            state <= B;
          end
        end
      endcase
    end
  end
  
  assign z = (state == A) ? 1'b0 : 1'b1; // Output z
  
endmodule
