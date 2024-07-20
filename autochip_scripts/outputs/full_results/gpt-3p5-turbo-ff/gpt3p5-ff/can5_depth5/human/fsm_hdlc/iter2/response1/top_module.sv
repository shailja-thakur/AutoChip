module top_module (
  input clk,
  input reset,
  input in,
  output reg disc,
  output reg flag,
  output reg err);

  reg [2:0] state;
  reg disc_next, flag_next, err_next;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b000;
    end else begin
      case(state)
        3'b000: begin
          if (in) begin
            state <= 3'b001;
          end else begin
            state <= 3'b000;
          end
        end
        3'b001: begin
          if (in) begin
            state <= 3'b010;
          end else begin
            state <= 3'b000;
          end
        end
        3'b010: begin
          if (in) begin
            state <= 3'b011;
          end else begin
            state <= 3'b000;
          end
        end
        3'b011: begin
          if (in) begin
            state <= 3'b100;
          end else begin
            state <= 3'b000;
          end
        end
        3'b100: begin
          if (in) begin
            state <= 3'b101;
          end else begin
            state <= 3'b000;
          end
        end
        3'b101: begin
          if (in) begin
            state <= 3'b110;
          end else begin
            state <= 3'b000;
          end
        end
        3'b110: begin
          if (in) begin
            state <= 3'b111;
          end else begin
            state <= 3'b000;
          end
        end
        3'b111: begin
          if (in) begin
            state <= 3'b111;
          end else begin
            state <= 3'b000;
          end
        end
        default: state <= 3'b000;
      endcase
    end
  end

  always @(posedge clk) begin
    disc_next <= 0;
    flag_next <= 0;
    err_next <= 0;
    case (state)
      3'b000: begin
        disc <= disc_next;
        flag <= flag_next;
        err <= err_next;
      end
      3'b001: begin
        disc <= disc_next;
        flag <= flag_next;
        err <= err_next;
      end
      3'b010: begin
        disc <= disc_next;
        flag <= flag_next;
        err <= err_next;
      end
      3'b011: begin
        disc <= disc_next;
        flag <= flag_next;
        err <= err_next;
      end
      3'b100: begin
        disc <= disc_next;
        flag <= flag_next;
        err <= err_next;
      end
      3'b101: begin
        disc <= disc_next;
        flag <= flag_next;
        err <= err_next;
      end
      3'b110: begin
        disc <= disc_next;
        flag <= flag_next;
        err <= err_next;
      end
      3'b111: begin
        disc <= disc_next;
        flag <= flag_next;
        err <= err_next;
      end
      default: begin
        disc <= 0;
        flag <= 0;
        err <= 0;
      end
    endcase
  end
  
endmodule
