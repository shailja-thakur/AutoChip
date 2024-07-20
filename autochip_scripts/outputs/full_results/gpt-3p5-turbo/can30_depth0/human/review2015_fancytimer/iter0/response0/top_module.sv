module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
  
  reg [7:0] shift_reg;
  reg [3:0] delay;
  reg [3:0] count_reg;

  enum {IDLE, SEARCH, START, COUNT, DONE} state;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= SEARCH;
      shift_reg <= 8'd0;
      delay <= 4'd0;
      counting <= 1'b0;
      done <= 1'b0;
      count_reg <= 4'd0;
    end else begin
      case (state)
        IDLE: begin
          if (data == 4'b1101) begin
            state <= START;
            shift_reg <= 8'd0;
            delay <= 4'd0;
            counting <= 1'b0;
            done <= 1'b0;
            count_reg <= 4'd0;
          end else begin
            state <= IDLE;
          end
        end
        
        SEARCH: begin
          if (data == 4'b1101) begin
            state <= START;
            shift_reg <= 8'd0;
            delay <= 4'd0;
            counting <= 1'b0;
            done <= 1'b0;
            count_reg <= 4'd0;
          end else begin
            state <= SEARCH;
          end
        end
        
        START: begin
          state <= COUNT;
          shift_reg <= {data, shift_reg[7:1]};
          delay <= shift_reg[7:4];
          counting <= 1'b1;
          done <= 1'b0;
          count_reg <= delay;
        end
        
        COUNT: begin
          if (count_reg > 0) begin
            state <= COUNT;
            shift_reg <= {data, shift_reg[7:1]};
            count_reg <= count_reg - 1;
            counting <= 1'b1;
          end else begin
            state <= DONE;
            shift_reg <= 8'd0;
            counting <= 1'b0;
            done <= 1'b1;
            count_reg <= 4'd0;
          end
        end
        
        DONE: begin
          if (ack) begin
            state <= SEARCH;
            shift_reg <= 8'd0;
            delay <= 4'd0;
            counting <= 1'b0;
            done <= 1'b0;
            count_reg <= 4'd0;
          end else begin
            state <= DONE;
          end
        end
      endcase
    end
  end
  
  assign count = counting ? count_reg : 4'd0;

endmodule
