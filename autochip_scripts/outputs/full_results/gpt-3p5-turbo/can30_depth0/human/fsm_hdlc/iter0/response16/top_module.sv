module top_module (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err);

  reg [2:0] state;
  
  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;
      disc <= 1'b0;
      flag <= 1'b0;
      err <= 1'b0;
    end else begin
      case(state)
        3'b000: begin
          if (in == 1'b0)
            state <= 3'b001;
          else
            state <= 3'b000;
        end
        3'b001: begin
          if (in == 1'b1)
            state <= 3'b010;
          else
            state <= 3'b001;
        end
        3'b010: begin
          if (in == 1'b1)
            state <= 3'b011;
          else
            state <= 3'b010;
        end
        3'b011: begin
          if (in == 1'b1)
            state <= 3'b100;
          else
            state <= 3'b011;
          flag <= 1'b0;
        end
        3'b100: begin
          if (in == 1'b1)
            state <= 3'b101;
          else
            state <= 3'b100;
          flag <= 1'b0;
        end
        3'b101: begin
          if (in == 1'b1)
            state <= 3'b110;
          else if (in == 1'b0)
            state <= 3'b001;
          else
            state <= 3'b101;
          disc <= 1'b0;
          flag <= 1'b0;
          err <= 1'b0;
        end
        3'b110: begin
          if (in == 1'b0)
            state <= 3'b111;
          else
            state <= 3'b110;
        end
        3'b111: begin
          if (in == 1'b0)
            state <= 3'b001;
          else if (in == 1'b1)
            state <= 3'b100;
          else
            state <= 3'b111;
          flag <= 1'b1;
        end
        default: state <= 3'b000;
      endcase
    end
  end
  
  // Error detection when there are 7 or more consecutive 1s
  always @(posedge clk) begin
    if (reset) begin
      err <= 1'b0;
    end else begin
      if (state == 3'b100 && in == 1'b1) begin
        err <= 1'b1;
      end else begin
        err <= 1'b0;
      end
    end
  end
  
  // Discard detection when there are 6 consecutive 1s
  always @(posedge clk) begin
    if (reset) begin
      disc <= 1'b0;
    end else begin
      if (state == 3'b101 && in == 1'b1) begin
        disc <= 1'b1;
      end else begin
        disc <= 1'b0;
      end
    end
  end

endmodule
