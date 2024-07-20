module top_module (
  input clk,
  input aresetn,
  input x,
  output reg z
);

  reg [1:0] state;
  
  always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
      state <= 0;
      z <= 0;
    end 
    else begin
      case (state)
        0: begin
          if (x == 1)
            state <= 1;
        end
        1: begin
          if (x == 0)
            state <= 2;
        end
        2: begin
          if (x == 1) begin
            state <= 0;
            z <= 1;
          end
          else
            state <= 1;
        end
        default: state <= 0;
      endcase
    end
  end

endmodule
