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
  if (reset) begin
    state <= 3'b0;
    out_reg <= 24'b0;
    done <= 1'b0;
  end else begin
    case (state)
      3'b000: begin // BYTE1
        if (in[2] == 1'b1)
          state <= 3'b001; // BYTE2
        else
          state <= 3'b000; // Stay in BYTE1
      end

      3'b001: begin // BYTE2
        if (in[2] == 1'b1)
          state <= 3'b010; // BYTE3
        else
          state <= 3'b001; // Stay in BYTE2
      end

      3'b010: begin // BYTE3
        state <= 3'b100; // DONE
      end

      3'b100: begin // DONE
        if (in[2] == 1'b1)
          state <= 3'b100; // Stay in DONE
        else
          state <= 3'b000; // Go back to BYTE1
      end
    endcase
  end
end

always @(posedge clk) begin
  if (state == 3'b100) begin
    out_reg <= {out_reg[15:0], in};
    done <= 1'b1;
  end else begin
    out_reg <= {out_reg[15:0], in};
    done <= 1'b0;
  end
end

assign out_bytes = out_reg;

endmodule
