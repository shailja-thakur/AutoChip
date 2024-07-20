module top_module (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);

  reg [3:1] state;
  
  always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
      state <= 3'b000;
    end else begin
      case(state)
        3'b000: begin
          if (r[1] && ~r[2] && ~r[3])
            state <= 3'b001;
          else if (~r[1] && r[2] && ~r[3])
            state <= 3'b010;
          else if (r[1] && r[2] && ~r[3])
            state <= 3'b011;
          else if (r[1] && ~r[2] && r[3])
            state <= 3'b100;
        end
        
        3'b001: begin
          if (~r[1] && ~r[2] && ~r[3])
            state <= 3'b000;
          else if (r[1] && ~r[2] && ~r[3])
            state <= 3'b001;
          else if (r[1] && ~r[2] && r[3])
            state <= 3'b100;
        end
        
        3'b010: begin
          if (~r[1] && ~r[2] && ~r[3])
            state <= 3'b000;
          else if (~r[1] && ~r[2] && r[3])
            state <= 3'b010;
          else if (r[1] && ~r[2] && r[3])
            state <= 3'b100;
        end
        
        3'b011: begin
          if (~r[1] && ~r[2] && ~r[3])
            state <= 3'b000;
          else if (~r[1] && r[2] && ~r[3])
            state <= 3'b001;
          else if (~r[1] && ~r[2] && r[3])
            state <= 3'b010;
          else if (r[1] && ~r[2] && r[3])
            state <= 3'b100;
        end
        
        3'b100: begin
          if (~r[1] && ~r[2] && ~r[3])
            state <= 3'b000;
          else if (r[1] && ~r[2] && r[3])
            state <= 3'b100;
        end
      endcase
    end
  end
  
  always @(state) begin
    case(state)
      3'b000: g = 3'b000;
      3'b001: g = 3'b001;
      3'b010: g = 3'b010;
      3'b011: g = 3'b010;
      3'b100: g = 3'b100;
    endcase
  end

endmodule
