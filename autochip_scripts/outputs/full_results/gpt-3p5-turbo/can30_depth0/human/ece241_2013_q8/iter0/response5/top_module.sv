module top_module (
  input clk,
  input aresetn,
  input x,
  output reg z
);

  reg [1:0] state;
  reg [4:0] count;

  parameter S0 = 2'b00;
  parameter S1 = 2'b01;
  parameter S2 = 2'b10;

  always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
      state <= S0;
      count <= 0;
    end else begin
      case (state)
        S0: begin
          if (x == 1'b1) begin
            state <= S1;
            count <= 1;
          end else begin
            state <= S0;
            count <= 0;
          end
        end
        
        S1: begin
          if (x == 1'b0) begin
            state <= S2;
            count <= 2;
          end else if (x == 1'b1) begin
            state <= S1;
            count <= count + 1;
          end else begin
            state <= S0;
            count <= 0;
          end
        end
        
        S2: begin
          if (x == 1'b1 && count == 3) begin
            state <= S0;
            count <= 0;
            z <= 1;
          end else if (x == 1'b1) begin
            state <= S1;
            count <= count + 1;
          end else begin
            state <= S0;
            count <= 0;
          end
        end
      endcase
    end
  end

  always @(negedge aresetn) begin
    if (!aresetn) begin
      z <= 0;
    end
  end

endmodule
