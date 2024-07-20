module top_module (
  input clk,
  input in,
  input reset,
  output reg out
);
  
  // Define states
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;
  
  // Define state register
  reg [1:0] state;
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= A;
    end else begin
      case (state)
        A: begin
          if (in) begin
            state <= B;
          end else begin
            state <= A;
          end
        end
        
        B: begin
          if (in) begin
            state <= C;
          end else begin
            state <= B;
          end
        end
        
        C: begin
          if (in) begin
            state <= D;
          end else begin
            state <= A;
          end
        end
        
        D: begin
          if (in) begin
            state <= B;
          end else begin
            state <= C;
          end
        end
          
        default: state <= A;
      endcase
    end
  end
  
  // Define output
  always @(state) begin
    case (state)
      A: out = 1'b0;
      B: out = 1'b0;
      C: out = 1'b0;
      D: out = 1'b1;
      default: out = 1'b0;
    endcase
  end
  
endmodule
