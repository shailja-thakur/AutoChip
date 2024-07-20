module top_module (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);

  reg [2:0] state;
  reg f_temp, g_temp;
  
  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      state <= 3'b000;
    else begin
      case (state)
        3'b000: begin // State A
          if (resetn)
            state <= 3'b001;
          else
            state <= 3'b000;
        end
        3'b001: begin // Transition state for f
          state <= 3'b010;
        end
        3'b010: begin // Check if x = 1, 0, 1
          if (x == 1 && f_temp == 0)
            state <= 3'b011;
          else
            state <= 3'b010;
        end
        3'b011: begin // Set g = 1
          state <= 3'b100;
        end
        3'b100: begin // Monitor y
          if (y == 1 && g_temp == 1)
            state <= 3'b101;
          else if (y == 1 && g_temp == 0)
            state <= 3'b110;
          else if (y == 0)
            state <= 3'b100;
        end
        3'b101: begin // Maintain g = 1 permanently (until reset)
          state <= 3'b101;
        end
        3'b110: begin // Set g = 0 permanently (until reset)
          state <= 3'b110;
        end
      endcase
    end
  end

  always @(state) begin
    f_temp = 0;
    g_temp = 0;
    
    case (state)
      3'b001: begin // Transition state for f
        f_temp = 1;
      end
      3'b011, 3'b101: begin // Set g = 1
        g_temp = 1;
      end
    endcase
  end

  assign f = f_temp;
  assign g = g_temp;

endmodule
