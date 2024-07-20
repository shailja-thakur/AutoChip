module top_module (
  input clk,
  input reset,
  input in,
  output reg disc,
  output reg flag,
  output reg err);

  reg [2:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b000;
      disc <= 0;
      flag <= 0;
      err <= 0;
    end else begin
      case (state)
        3'b000: begin
          if (in == 1) begin
            state <= 3'b001;
          end else begin
            state <= 3'b000;
          end
        end
        3'b001: begin
          if (in == 1) begin
            state <= 3'b010;
          end else begin
            state <= 3'b000;
          end
        end
        3'b010: begin
          if (in == 1) begin
            state <= 3'b011;
          end else begin
            state <= 3'b000;
          end
        end
        3'b011: begin
          if (in == 1) begin
            state <= 3'b100;
            disc <= 1;
          end else begin
            state <= 3'b000;
          end
        end
        3'b100: begin
          if (in == 0) begin
            state <= 3'b101;
          end else begin
            state <= 3'b000;
          end
        end
        3'b101: begin
          if (in == 1) begin
            state <= 3'b110;
            flag <= 1;
          end else if (in == 0) begin
            state <= 3'b000;
          end else begin
            state <= 3'b111;
            err <= 1;
          end
        end
        3'b110: begin
          if (in == 0) begin
            state <= 3'b011;
            flag <= 0;
          end else begin
            state <= 3'b111;
            err <= 1;
          end
        end
        3'b111: begin
          if (in == 1) begin
            state <= 3'b111;
            err <= 1;
          end else begin
            state <= 3'b000;
          end
        end
        default: begin
          state <= 3'b000;
        end
      endcase
    end
  end
endmodule
