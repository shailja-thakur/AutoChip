module top_module (
  input clk,
  input resetn,
  input x,
  input y,
  output reg f,
  output reg g
);

  reg [1:0] state;
  reg f_temp, g_temp;
  
  // Registers for x input
  reg [2:0] x_register;
  reg [2:0] x_previous;

  // Counter to keep track of clock cycles
  reg [1:0] count;

  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      state <= 2'b00;
    else begin
      case (state)
        2'b00: begin // State A
          if (!resetn)
            state <= 2'b00;
          else
            state <= 2'b01;
        end
        2'b01: begin // Transition state for f
          state <= 2'b10;
        end
        2'b10: begin // Check if x = 1, 0, 1
          if (x == 1 && x_previous == 0)
            state <= 2'b11;
          else begin
            x_previous <= x;
            state <= 2'b10;
          end
        end
        2'b11: begin // Set g = 1
          state <= 2'b11;
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if (!resetn)
      count <= 2'b00;
    else
      count <= count + 1;
  end

  always @(posedge clk) begin
    f_temp <= 0;
    g_temp <= 0;

    case (state)
      2'b01: begin // Transition state for f
        f_temp <= 1;
      end
      2'b11: begin // Set g = 1
        g_temp <= 1;
      end
    endcase
  end

  always @(negedge resetn) begin
    if (!resetn)
      x_register <= 0;
    else
      x_register <= {x_register[1:0], x};
  end

  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      f <= 0;
    else
      f <= f_temp;
  end

  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      g <= 0;
    else
      g <= g_temp;
  end

endmodule
