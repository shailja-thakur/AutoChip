module top_module (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);

  reg [2:0] state;
  reg [7:0] data;

  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;
      data <= 8'b0;
      out_byte <= 8'b0;
      done <= 0;
    end else begin
      case (state)
        3'b000:
          if (in) begin
            state <= 3'b001;
            data[0] <= 1'b0;
          end
        3'b001:
          begin
            if (in) begin
              state <= 3'b010;
              data[1] <= 1'b0;
            end else begin
              state <= 3'b000;
              data <= 8'b0;
            end
          end
        3'b010:
          begin
            if (in) begin
              state <= 3'b011;
              data[2] <= 1'b0;
            end else begin
              state <= 3'b000;
              data <= 8'b0;
            end
          end
        3'b011:
          begin
            if (in) begin
              state <= 3'b100;
              data[3] <= 1'b0;
            end else begin
              state <= 3'b000;
              data <= 8'b0;
            end
          end
        3'b100:
          begin
            if (in) begin
              state <= 3'b101;
              data[4] <= 1'b0;
            end else begin
              state <= 3'b000;
              data <= 8'b0;
            end
          end
        3'b101:
          begin
            if (in) begin
              state <= 3'b110;
              data[5] <= 1'b0;
            end else begin
              state <= 3'b000;
              data <= 8'b0;
            end
          end
        3'b110:
          begin
            if (in) begin
              state <= 3'b111;
              data[6] <= 1'b0;
            end else begin
              state <= 3'b000;
              data <= 8'b0;
            end
          end
        3'b111:
          begin
            if (in) begin
              state <= 3'b010;
              data[7] <= 1'b0;
            end else begin
              state <= 3'b000;
              data <= 8'b0;
            end
          end
      endcase
      if (state == 3'b010) begin
        if (~in)
          state <= 3'b000;
        else
          state <= 3'b011;
      end
    end
  end

  always @(posedge clk) begin
    if (state == 3'b010)
      done <= 1;
    else
      done <= 0;
  end

  assign out_byte = data;
endmodule
