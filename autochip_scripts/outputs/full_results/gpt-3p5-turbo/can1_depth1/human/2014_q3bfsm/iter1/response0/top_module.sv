module top_module (
  input clk,
  input reset,
  input x,
  output reg z
);
  
  reg [2:0] y, next_y;
  reg [2:0] y_reg;
  
  // Combining x with y[2:0] to get next_y[2:0]
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      y <= 3'b000;
    end else begin
      y <= next_y;
    end
  end
  
  // Register for y[2:0]
  always @(posedge clk) begin
    y_reg <= y;
  end
  
  // Combinatorial logic for next_y and z
  always @* begin
    case(y_reg)
      3'b000: begin
        if (x == 1'b0) begin
          next_y = 3'b000;
          z = 1'b0;
        end else begin
          next_y = 3'b001;
          z = 1'b0;
        end
      end
      
      3'b001: begin
        if (x == 1'b0) begin
          next_y = 3'b001;
          z = 1'b0;
        end else begin
          next_y = 3'b100;
          z = 1'b0;
        end
      end
      
      3'b010: begin
        if (x == 1'b0) begin
          next_y = 3'b010;
          z = 1'b0;
        end else begin
          next_y = 3'b001;
          z = 1'b0;
        end
      end
      
      3'b011: begin
        if (x == 1'b0) begin
          next_y = 3'b001;
          z = 1'b0;
        end else begin
          next_y = 3'b010;
          z = 1'b1;
        end
      end
      
      3'b100: begin
        if (x == 1'b0) begin
          next_y = 3'b011;
          z = 1'b1;
        end else begin
          next_y = 3'b100;
          z = 1'b1;
        end
      end
    endcase
  end

endmodule
