module top_module (
  input clk,
  input reset,
  input in,
  output reg disc,
  output reg flag,
  output reg err);

  reg [3:0] state;
  reg [5:0] ones_count;
  reg prev_in;

  always @(posedge clk) begin
    if (reset) begin
      state <= 4'b0000;
      ones_count <= 6'b000000;
      disc <= 0;
      flag <= 0;
      err <= 0;
    end else begin
      prev_in <= in;
      case(state)
        4'b0000: begin
          flag <= 0;
          err <= 0;
          if (in) begin
            state <= 4'b0001;
          end else begin
            state <= 4'b0000;
          end
        end
        4'b0001: begin
          flag <= 0;
          err <= 0;
          ones_count <= 6'b000001;
          if (in) begin
            state <= 4'b0010;
          end else begin
            state <= 4'b0000;
          end
        end
        4'b0010: begin
          flag <= 0;
          err <= 0;
          if (in) begin
            ones_count <= ones_count + 1;
            if (ones_count == 6'b111111) begin
              state <= 4'b0011;
            end else if (ones_count == 6'b11111) begin
              state <= 4'b0100;
            end else begin
              state <= 4'b0010;
            end
          end else begin
            ones_count <= 0;
            state <= 4'b0000;
          end
        end
        4'b0011: begin
          flag <= 1;
          err <= 0;
          if (in) begin
            state <= 4'b0011;
          end else begin
            ones_count <= 0;
            state <= 4'b0000;
          end
        end
        4'b0100: begin
          flag <= 0;
          err <= 0;
          if (in) begin
            state <= 4'b0010;
          end else begin
            state <= 4'b0000;
          end
        end
        4'b0101: begin
          flag <= 0;
          err <= 1;
          if (in) begin
            state <= 4'b0101;
          end else begin
            state <= 4'b0000;
          end
        end
        default: begin
          flag <= 0;
          err <= 0;
          state <= 4'b0000;
        end
      endcase
    end
  end
  
endmodule
