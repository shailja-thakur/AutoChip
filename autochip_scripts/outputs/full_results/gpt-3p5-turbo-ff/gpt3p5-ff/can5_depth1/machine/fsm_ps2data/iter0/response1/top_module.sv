module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);

  reg [23:0] out_bytes_reg;
  reg [23:0] out_bytes_next;
  reg [2:0] state;
  reg done_next;
  
  always @(posedge clk) begin
    if (reset) begin
      out_bytes_reg <= 0;
      state <= 0;
      done_next <= 0;
    end
    else begin
      out_bytes_reg <= out_bytes_next;
      state <= state_next;
      done_next <= done;
    end
  end
  
  always @(state or in) begin
    case (state)
      0: begin // BYTE1
        if (in[2] == 1)
          state_next = 1; // BYTE2
        else
          state_next = 0;
      end
      
      1: begin // BYTE2
        state_next = 2; // BYTE3
      end
      
      2: begin // BYTE3
        state_next = 3; // DONE
      end
      
      3: begin // DONE
        if (in[2] == 0)
          state_next = 0; // BYTE1
        else
          state_next = 3;
      end
    endcase
  end
  
  always @(posedge clk) begin
    if (state == 3)
      done <= done_next;
    else
      done <= 0;
  end
  
  always @(posedge clk) begin
    if (state == 0)
      out_bytes_next <= {in, out_bytes_reg[23:8]};
    else
      out_bytes_next <= out_bytes_reg;
  end
  
  assign out_bytes = out_bytes_reg;

endmodule
