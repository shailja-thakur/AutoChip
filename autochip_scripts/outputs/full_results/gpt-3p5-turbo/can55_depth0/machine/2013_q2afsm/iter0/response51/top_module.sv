module top_module (
  input clk,
  input resetn,
  input [2:0] r,
  output [2:0] g
);
  
  reg [3:0] state;
  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      state <= 4'b0000;
    end else begin
      case(state)
        4'b0000: begin
          if (r[0]) begin
            state <= 4'b0010;
          end else if (r[1]) begin
            state <= 4'b0100;
          end else if (r[2]) begin
            state <= 4'b1000;
          end else begin
            state <= 4'b0001;
          end
        end
        
        4'b0010: begin
          if (!r[0]) begin
            state <= 4'b0001;
          end
        end
        
        4'b0100: begin
          if (!r[1]) begin
            state <= 4'b0001;
          end
        end
        
        4'b1000: begin
          if (!r[2]) begin
            state <= 4'b0001;
          end
        end
        
        default: begin
          state <= 4'b0001;
        end
      endcase
    end
  end
  
  always @(posedge clk) begin
    case(state)
      4'b0010: begin
        g[0] <= 1'b0;
        g[1] <= 1'b1;
        g[2] <= 1'b0;
      end
      
      4'b0100: begin
        g[0] <= 1'b0;
        g[1] <= 1'b0;
        g[2] <= 1'b1;
      end
      
      4'b1000: begin
        g[0] <= 1'b0;
        g[1] <= 1'b0;
        g[2] <= 1'b0;
        g[3] <= 1'b1;
      end
      
      default: begin
        g[0] <= 1'b0;
        g[1] <= 1'b0;
        g[2] <= 1'b0;
        g[3] <= 1'b0;
      end
    endcase
  end
endmodule
