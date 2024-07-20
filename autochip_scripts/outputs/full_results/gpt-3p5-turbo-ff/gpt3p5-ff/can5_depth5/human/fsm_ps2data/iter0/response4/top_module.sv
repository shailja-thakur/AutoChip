module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

  reg [7:0] in_reg [2:0];
  reg [23:0] out_bytes_reg;
  reg [2:0] state;
  
  always @(posedge clk) begin
    if (reset) begin
      in_reg <= 0;
      out_bytes_reg <= 0;
      state <= 0;
    end else begin
      in_reg <= {in_reg[1:0], in};
      out_bytes_reg <= {out_bytes_reg[15:0], in_reg[0]};
      
      case(state)
        0: begin // Idle state
          if (in_reg[0][3]) begin
            state <= 1;
          end
        end
        1: begin // Byte 1 received
          if (in_reg[0][3]) begin
            state <= 2;
          end else begin
            state <= 0;
          end
        end
        2: begin // Byte 2 received
          if (in_reg[0][3]) begin
            state <= 3;
          end else begin
            state <= 0;
          end
        end
        3: begin // Byte 3 received
          state <= 0;
        end
      endcase
    end
  end
  
  assign out_bytes = out_bytes_reg;
  assign done = (state == 3);
  
endmodule
