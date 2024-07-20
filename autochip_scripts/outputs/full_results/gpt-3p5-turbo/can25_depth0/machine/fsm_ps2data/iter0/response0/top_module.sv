module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
  );

  reg [1:0] state;
  reg [23:0] reg_out_bytes;
  
  always @ (posedge clk or posedge reset) begin
    if (reset)
      state <= 2'b00;
    else begin
      case (state)
        2'b00: begin // BYTE1
          if (in[2] == 1'b1)
            state <= 2'b01;
          else
            state <= 2'b00;
        end
        2'b01: begin // BYTE2
          if (in[2] == 1'b1)
            state <= 2'b10;
          else
            state <= 2'b00;
        end
        2'b10: begin // BYTE3
          state <= 2'b11;
        end
        2'b11: begin // DONE
          if (in[2] == 1'b0)
            state <= 2'b00;
          else
            state <= 2'b11;
        end
        default: begin
          state <= 2'b00;
        end
      endcase
    end
  end

  always @ (posedge clk) begin
    if (reset)
      reg_out_bytes <= 0;
    else begin
      case (state)
        2'b00: begin // BYTE1
          reg_out_bytes <= {reg_out_bytes[15:0], in};
        end
        2'b01: begin // BYTE2
          reg_out_bytes <= {reg_out_bytes[15:0], in};
        end
        2'b10: begin // BYTE3
          reg_out_bytes <= {reg_out_bytes[15:0], in};
        end
        2'b11: begin // DONE
          reg_out_bytes <= reg_out_bytes;
        end
        default: begin
          reg_out_bytes <= 0;
        end
      endcase
    end
  end

  always @ (posedge clk) begin
    done <= (state == 2'b11);
    out_bytes <= (done) ? reg_out_bytes : 0;
  end

endmodule
