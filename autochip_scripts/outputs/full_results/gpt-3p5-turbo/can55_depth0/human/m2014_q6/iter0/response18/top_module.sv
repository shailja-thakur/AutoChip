module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);

  reg [2:0] state;
  
  always @(posedge clk or posedge reset) begin
    if(reset)
      state <= 3'b000;
    else begin
      case(state)
        3'b000: begin // State A
          if(w)
            state <= 3'b000;
          else
            state <= 3'b001;
        end
        3'b001: begin // State B
          if(w)
            state <= 3'b011;
          else
            state <= 3'b010;
        end
        3'b010: begin // State C
          if(w)
            state <= 3'b010;
          else
            state <= 3'b011;
        end
        3'b011: begin // State D
          if(w)
            state <= 3'b000;
          else
            state <= 3'b100;
        end
        3'b100: begin // State E
          if(w)
            state <= 3'b100;
          else
            state <= 3'b011;
        end
        3'b101: begin // State F
          if(w)
            state <= 3'b010;
          else
            state <= 3'b011;
        end
      endcase
    end
  end
  
  always @(state) begin
    case(state)
      3'b000: z <= 1'b0; // State A, output 0
      3'b001: z <= 1'b0; // State B, output 0
      3'b010: z <= 1'b0; // State C, output 0
      3'b011: z <= 1'b0; // State D, output 0
      3'b100: z <= 1'b1; // State E, output 1
      3'b101: z <= 1'b0; // State F, output 0
    endcase
  end
  
endmodule
