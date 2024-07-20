module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

  reg [1:0] state, next_state;
  reg [3:1] g_internal;
  
  parameter A = 2'b00;
  parameter B = 2'b01;
  parameter C = 2'b10;
  parameter D = 2'b11;
  
  always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
      state <= A;
    end else begin
      state <= next_state;
    end
  end
  
  always @(state or r) begin
    case(state)
      A: begin
        if(r[1] && r[2] && r[3]) begin
          next_state = A;
          g_internal = 3'b000;
        end else if (r[1]) begin
          next_state = B;
          g_internal = 3'b100;
        end else if (r[2]) begin
          next_state = C;
          g_internal = 3'b010;
        end else if (r[3]) begin
          next_state = D;
          g_internal = 3'b001;
        end
      end
      
      B: begin
        if (g_internal[1] == 1 && ~r[1]) begin
          next_state = A;
          g_internal = 3'b000;
        end else if (r[1]) begin
          next_state = B;
          g_internal = 3'b100;
        end
      end
      
      C: begin
        if (g_internal[2] == 1 && ~r[2]) begin
          next_state = A;
          g_internal = 3'b000;
        end else if (r[2]) begin
          next_state = C;
          g_internal = 3'b010;
        end
      end
      
      D: begin
        if (r[1] || r[2] || r[3]) begin
          next_state = D;
          g_internal = 3'b000;
        end else begin
          next_state = A;
          g_internal = 3'b000;
        end
      end
    endcase
  end
  
  assign g = g_internal;
  
endmodule
