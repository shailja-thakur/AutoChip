module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

  reg [3:1] state, next_state;
  wire [3:1] g_temp;
  
  // State assignments
  parameter A = 3'b001;
  parameter B = 3'b010;
  parameter C = 3'b011;
  parameter D = 3'b100;
  
  // Output assignments
  assign g = g_temp;
  
  // State flip-flop
  always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
      state <= A;
    end else begin
      state <= next_state;
    end
  end
  
  // State table
  always @* begin
    case(state)
      A: begin
        if (r[1] && r[2] && r[3]) begin
          next_state = A;
          g_temp = 3'b000;
        end else if (r[1]) begin
          next_state = B;
          g_temp = 3'b100;
        end else if (r[2]) begin
          next_state = C;
          g_temp = 3'b010;
        end else if (r[3]) begin
          next_state = D;
          g_temp = 3'b001;
        end
      end
      
      B: begin
        if (r[1]) begin
          next_state = B;
          g_temp = 3'b100;
        end else begin
          next_state = A;
          g_temp = 3'b000;
        end
      end
      
      C: begin
        if (r[2]) begin
          next_state = C;
          g_temp = 3'b010;
        end else begin
          next_state = A;
          g_temp = 3'b000;
        end
      end
      
      D: begin
        if (r[1] && r[2] && r[3]) begin
          next_state = D;
          g_temp = 3'b001;
        end else begin
          next_state = A;
          g_temp = 3'b000;
        end
      end
    endcase
  end
endmodule
