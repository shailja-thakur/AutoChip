module top_module(
  input wire clk,
  input wire reset,
  input wire data,
  output wire [3:0] count,
  output reg counting,
  output reg done,
  input wire ack );

  reg [3:0] delay;
  reg [3:0] count_delay;
  reg [3:0] count_remain;
  reg [3:0] state;
  reg [3:0] next_state;

  parameter IDLE_STATE = 4'b0000;
  parameter DETECT_STATE = 4'b0001;
  parameter COUNT_STATE = 4'b0010;
  parameter FINISH_STATE = 4'b0011;

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      counting <= 0;
      done <= 0;
      state <= IDLE_STATE;
      count_remain <= 4'b0000;
      count_delay <= 4'b0000;
    end else begin
      count <= count_delay;
      case(state)
        IDLE_STATE: begin
          if(data==1) begin
            if(data==1 && $past(data)==1) begin
              next_state <= DETECT_STATE;
              delay <= 4'b0000;
            end else begin
              next_state <= IDLE_STATE;
              delay <= count_delay;
            end
          end else begin
            next_state <= IDLE_STATE;
            delay <= count_delay;
          end
        end
        DETECT_STATE: begin
          if(data==0) begin
            next_state <= IDLE_STATE;
            delay <= count_delay;
          end else begin
            case(count_remain)
              4'b0000: begin
                next_state <= COUNT_STATE;
                count_delay <= delay;
                count_remain <= delay;
              end
              default: begin
                next_state <= DETECT_STATE;
                count_remain <= count_remain - 4'b0001;
              end
            endcase
          end
        end
        COUNT_STATE: begin
          if(count_remain==4'b0000) begin
            next_state <= FINISH_STATE;
            counting <= 0;
          end else begin
            next_state <= COUNT_STATE;
            counting <= 1;
            count_remain <= count_remain - 4'b0001;
          end
        end
        FINISH_STATE: begin
          if(ack) begin
            next_state <= IDLE_STATE;
            delay <= 4'b0000;
          end else begin
            next_state <= FINISH_STATE;
            delay <= 4'b0000;
            done <= 1;
          end
        end
        default: begin
          next_state <= IDLE_STATE;
          delay <= count_delay;
        end
      endcase
    end
  end

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      counting <= 0;
      done <= 0;
      state <= IDLE_STATE;
      count_remain <= 4'b0000;
      count_delay <= 4'b0000;
    end else begin
      state <= next_state;
    end
  end

endmodule
