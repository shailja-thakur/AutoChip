module top_module (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err);

  reg [2:0] state;
  reg disc_next, flag_next, err_next;
  reg prev_in;

  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;
    end else begin
      prev_in <= in;
      case(state)
        3'b000: begin
          if(in) begin
            state <= 3'b001;
          end else begin
            state <= 3'b000;
          end
        end
        3'b001: begin
          if(in) begin
            state <= 3'b010;
          end else begin
            state <= 3'b000;
          end
        end
        3'b010: begin
          if(in) begin
            state <= 3'b011;
          end else begin
            state <= 3'b000;
          end
        end
        3'b011: begin
          if(in) begin
            state <= 3'b100;
          end else begin
            state <= 3'b000;
          end
        end
        3'b100: begin
          if(in) begin
            state <= 3'b101;
          end else begin
            state <= 3'b000;
          end
        end
        3'b101: begin
          if(in) begin
            state <= 3'b110;
          end else begin
            state <= 3'b000;
          end
        end
        3'b110: begin
          if(in) begin
            state <= 3'b111;
          end else begin
            state <= 3'b000;
          end
        end
        3'b111: begin
          if(in) begin
            state <= 3'b111;
          end else begin
            state <= 3'b000;
          end
        end
        default: state <= 3'b000;
      endcase
    end
  end

  always @(state, in) begin
    case(state)
      3'b011: begin
        disc_next <= 1;
        flag_next <= 0;
        err_next <= 0;
      end
      3'b100: begin
        disc_next <= 0;
        flag_next <= 1;
        err_next <= 0;
      end
      3'b111: begin
        disc_next <= 0;
        flag_next <= 0;
        err_next <= 1;
      end
      default: begin
        disc_next <= 0;
        flag_next <= 0;
        err_next <= 0;
      end
    endcase
  end

  assign disc = disc_next;
  assign flag = flag_next;
  assign err = err_next;
  
endmodule
