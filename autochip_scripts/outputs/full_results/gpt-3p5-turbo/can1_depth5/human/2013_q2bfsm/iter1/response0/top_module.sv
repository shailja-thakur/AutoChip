module top_module (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);

  reg [1:0] state;
  reg f_temp, g_temp;
  reg f_next, g_next;
  reg [2:0] x_register;

  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      state <= 2'b00;
    else begin
      case (state)
        2'b00: begin // State A
          if (resetn)
            state <= 2'b01;
          else
            state <= 2'b00;
        end
        2'b01: begin // Transition state for f
          state <= 2'b10;
        end
        2'b10: begin // Check if x = 1, 0, 1
          if (x_register == 3'b101)
            state <= 2'b11;
          else
            state <= 2'b10;
        end
        2'b11: begin // Set g = 1
          state <= 2'b10;
        end
      endcase
    end
  end

  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      x_register <= {2{1'b0}};
    else
      x_register <= {x_register[1:0], x};
  end

  always @(state) begin
    f_next = 0;
    g_next = 0;

    case (state)
      2'b01: begin // Transition state for f
        f_next = 1;
      end
      2'b11: begin // Set g = 1
        g_next = 1;
      end
    endcase
  end

  always @(posedge clk) begin
    f_temp <= f_next;
    g_temp <= g_next;
  end

  assign f = f_temp;
  assign g = g_temp;

endmodule
