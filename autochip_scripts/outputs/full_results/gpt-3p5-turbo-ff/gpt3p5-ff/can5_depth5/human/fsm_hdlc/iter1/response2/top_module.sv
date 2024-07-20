module top_module (
  input clk,
  input reset,
  input in,
  output reg disc,
  output reg flag,
  output reg err);

  reg [2:0] state;
  reg [4:0] count;
  reg prev_in;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b000;
      count <= 0;
      disc <= 0;
      flag <= 0;
      err <= 0;
      prev_in <= 0;
    end else begin
      prev_in <= in;
      case(state)
        3'b000: begin
          if (in) begin
            count <= 1;
            state <= 3'b001;
          end else begin
            count <= 0;
            state <= 3'b000;
          end
        end
        3'b001: begin
          if (in) begin
            count <= count + 1;
            if (count == 5) begin
              count <= 0;
              state <= 3'b010;
              disc <= 1;
            end else begin
              state <= 3'b001;
            end
          end else begin
            count <= 0;
            state <= 3'b000;
          end
        end
        3'b010: begin
          if (in) begin
            state <= 3'b011;
          end else begin
            count <= 0;
            state <= 3'b000;
          end
        end
        3'b011: begin
          if (in) begin
            count <= 1;
            state <= 3'b100;
          end else begin
            count <= 0;
            state <= 3'b000;
          end
        end
        3'b100: begin
          if (in) begin
            count <= count + 1;
            if (count >= 7) begin
              count <= 0;
              state <= 3'b101;
              err <= 1;
            end else begin
              state <= 3'b100;
            end
          end else begin
            count <= 0;
            state <= 3'b000;
          end
        end
        3'b101: begin
          if (in) begin
            state <= 3'b110;
          end else begin
            count <= 0;
            state <= 3'b000;
          end
        end
        3'b110: begin
          if (in) begin
            count <= count + 1;
            state <= 3'b111;
          end else begin
            count <= 0;
            state <= 3'b000;
          end
        end
        3'b111: begin
          if (in) begin
            count <= count + 1;
            state <= 3'b111;
          end else begin
            count <= 0;
            state <= 3'b000;
          end
        end
        default: state <= 3'b000;
      endcase
    end
  end

endmodule
