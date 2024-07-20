module top_module (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err);

  reg [2:0] state;
  reg disc_reg, flag_reg, err_reg;
  reg disc_next, flag_next, err_next;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 3'b000;
    end else begin
      state <= state;
    end
  end

  always @(state or in) begin
    case(state)
      3'b000: begin
        disc_next = 0;
        flag_next = 0;
        err_next = 0;
        if (in) begin
          state <= 3'b001;
        end
      end
      3'b001: begin
        disc_next = 0;
        flag_next = 0;
        err_next = 0;
        if (in) begin
          state <= 3'b010;
        end else begin
          state <= 3'b000;
        end
      end
      3'b010: begin
        disc_next = 0;
        flag_next = 0;
        err_next = 0;
        if (in) begin
          state <= 3'b011;
        end else begin
          state <= 3'b000;
        end
      end
      3'b011: begin
        disc_next = 1;
        flag_next = 0;
        err_next = 0;
        if (in) begin
          state <= 3'b100;
        end else begin
          state <= 3'b000;
        end
      end
      3'b100: begin
        disc_next = 0;
        flag_next = 1;
        err_next = 0;
        if (in) begin
          state <= 3'b101;
        end else begin
          state <= 3'b000;
        end
      end
      3'b101: begin
        disc_next = 0;
        flag_next = 0;
        err_next = 0;
        if (in) begin
          state <= 3'b110;
        end else begin
          state <= 3'b000;
        end
      end
      3'b110: begin
        disc_next = 0;
        flag_next = 0;
        err_next = 1;
        if (in) begin
          state <= 3'b111;
        end else begin
          state <= 3'b000;
        end
      end
      3'b111: begin
        disc_next = 0;
        flag_next = 0;
        err_next = 1;
        if (in) begin
          state <= 3'b111;
        end else begin
          state <= 3'b000;
        end
      end
      default: state <= 3'b000;
    endcase
  end

  always @(posedge clk) begin
    disc_reg <= disc_next;
    flag_reg <= flag_next;
    err_reg <= err_next;
  end

  assign disc = disc_reg;
  assign flag = flag_reg;
  assign err = err_reg;
  
endmodule
