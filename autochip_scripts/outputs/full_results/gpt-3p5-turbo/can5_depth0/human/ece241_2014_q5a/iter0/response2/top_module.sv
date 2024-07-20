module top_module (
  input clk,
  input areset,
  input x,
  output z
);
  
  reg [3:0] state;
  reg [3:0] next_state;
  
  // Constants for states
  parameter S0 = 4'b0000;
  parameter S1 = 4'b0001;
  parameter S2 = 4'b0010;
  parameter S3 = 4'b0011;
  
  // Output register
  reg z_reg;
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= S0;
    end else begin
      state <= next_state;
    end
  end
  
  always @* begin
    case (state)
      S0: begin
        if (areset) begin
          next_state = S0;
          z_reg <= 1'b0;
        end else begin
          if (x) begin
            next_state = S1;
            z_reg <= 1'b1;
          end else begin
            next_state = S0;
            z_reg <= 1'b0;
          end
        end
      end
      
      S1: begin
        if (x) begin
          next_state = S1;
          z_reg <= ~z_reg;
        end else begin
          next_state = S2;
        end
      end
      
      S2: begin
        if (x) begin
          next_state = S3;
          z_reg <= ~z_reg;
        end else begin
          next_state = S2;
        end
      end
      
      S3: begin
        next_state = S3;
        z_reg <= ~z_reg;
      end
    endcase
  end
  
  assign z = z_reg;
  
endmodule
