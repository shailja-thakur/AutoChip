module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);

  reg [23:0] out_reg;
  reg [2:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 3'b000;
    else begin
      case (state)
        3'b000: begin // BYTE1
          if (in[2])
            state <= 3'b001; // BYTE2
          else
            state <= 3'b000; // BYTE1
        end
        3'b001: begin // BYTE2
          if (in[2])
            state <= 3'b010; // BYTE3
          else
            state <= 3'b001; // BYTE2
        end
        3'b010: begin // BYTE3
          state <= 3'b011; // DONE
        end
        3'b011: begin // DONE
          if (in[2])
            state <= 3'b000; // BYTE1
          else
            state <= 3'b000; // BYTE1
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if (reset)
      out_reg <= 24'b0;
    else begin
      if (state == 3'b011) // DONE
        out_reg <= in;
      else
        out_reg <= {out_reg[15:0], in};
    end
  end

  assign done = (state == 3'b011); // DONE
  assign out_bytes = out_reg;

endmodule
