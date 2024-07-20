module top_module (
  input clk,
  input reset,
  input x,
  output reg z
);

  reg [2:0] present_state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      present_state <= 3'd0;
    else begin
      case(present_state)
        3'd0: begin
          if (x)
            present_state <= 3'd1;
          else
            present_state <= 3'd0;
        end
        
        3'd1: begin
          if (x)
            present_state <= 3'd4;
          else
            present_state <= 3'd1;
        end
        
        3'd2: begin
          if (x)
            present_state <= 3'd1;
          else
            present_state <= 3'd2;
        end
        
        3'd3: begin
          if (x)
            present_state <= 3'd2;
          else
            present_state <= 3'd1;
        end
        
        3'd4: begin
          if (x)
            present_state <= 3'd6;
          else
            present_state <= 3'd4;
        end
        
        default: present_state <= 3'd0;
      endcase
    end
  end
  
  always @(posedge clk) begin
    case(present_state)
      3'd0: z <= 1'b0;
      3'd1: z <= 1'b0;
      3'd2: z <= 1'b0;
      3'd3: z <= 1'b1;
      3'd4: z <= 1'b1;
      default: z <= 1'b0;
    endcase
  end
  
endmodule
