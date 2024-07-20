module top_module (
  input clk,
  input reset,
  input w,
  output z
);

  reg [2:0] state;
  
  always @(posedge clk, posedge reset) begin
    if (reset)
      state <= 3'b000;
    else begin
      case (state)
        3'b000: begin
          if (w)
            state <= 3'b000;
          else
            state <= 3'b001;
        end
        
        3'b001: begin
          if (w)
            state <= 3'b010;
          else
            state <= 3'b001;
        end
        
        3'b010: begin
          if (w)
            state <= 3'b100;
          else
            state <= 3'b011;
        end
        
        3'b011: begin
          if (w)
            state <= 3'b010;
          else
            state <= 3'b001;
        end
        
        3'b100: begin
          if (w)
            state <= 3'b100;
          else
            state <= 3'b011;
        end
        
        default: state <= 3'b000;
      endcase
    end
  end
  
  assign z = (state == 3'b110);
  
endmodule
