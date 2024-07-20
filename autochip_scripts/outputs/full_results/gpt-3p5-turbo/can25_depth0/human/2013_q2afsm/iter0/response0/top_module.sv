module top_module (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);

  reg [3:1] state, next_state;
  reg [3:1] g_temp;
  reg [3:1] g_out;

  parameter A = 3'b001;
  parameter B = 3'b010;
  parameter C = 3'b011;
  parameter D = 3'b100;

  always @(posedge clk) begin
    if (!resetn) begin
      state <= A;
    end
    else begin
      state <= next_state;
    end
  end

  always @(state, r) begin
    case(state)
      A: begin
        if (r[1] & !r[2] & !r[3])
          next_state = D;
        else if (r[1] & !r[2] & r[3])
          next_state = C;
        else if (r[1] & r[2] & !r[3])
          next_state = B;
        else if (r[1])
          next_state = B;
        else
          next_state = A;
      end
      
      B: begin
        if (r[1] & g_temp[1])
          next_state = B;
        else if (!r[1] & !g_temp[1])
          next_state = A;
        else
          next_state = B;
      end
      
      C: begin
        if (r[2] & g_temp[2])
          next_state = C;
        else if (!r[2] & !g_temp[2])
          next_state = A;
        else
          next_state = C;
      end
      
      D: begin
        if (r[1] & !r[2] & !r[3])
          next_state = D;
        else if (!r[1] & !r[2] & !r[3])
          next_state = A;
        else
          next_state = D;
      end
    endcase
  end

  always @(posedge clk) begin
    if (!resetn) begin
      g_temp <= 3'b000;
      g_out <= 3'b000;
    end
    else begin
      case(state)
        A: begin
          g_temp <= 3'b000;
          g_out <= 3'b000;
        end
        
        B: begin
          if (r[1] & g_temp[1])
            g_temp <= 3'b010;
          else
            g_temp <= 3'b001;
          g_out <= g_temp;
        end
        
        C: begin
          if (r[2] & g_temp[2])
            g_temp <= 3'b010;
          else
            g_temp <= 3'b001;
          g_out <= g_temp;
        end
        
        D: begin
          g_temp <= 3'b000;
          g_out <= 3'b000;
        end
      endcase
    end
  end

  assign g = g_out;
  
endmodule
