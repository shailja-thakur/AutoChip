module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

  reg [3:0] shift_reg;
  reg [3:0] shift_reg_prev;
  reg [3:0] delay;
  reg [31:0] counter;
  reg [31:0] timer_count;
  reg [31:0] internal_counter;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      shift_reg <= 4'b0000;
      shift_reg_prev <= 4'b0000;
      delay <= 4'b0000;
      counter <= 32'd0;
      timer_count <= 32'd0;
      internal_counter <= 32'd0;
      counting <= 0;
      done <= 0;
    end else begin
      shift_reg_prev <= shift_reg;
      shift_reg <= {data, shift_reg[3:1]};
      
      if ((shift_reg == 4'b1101) && (shift_reg_prev != shift_reg)) begin
        delay <= shift_reg[3:0];
        timer_count <= (delay + 1) * 1000;
        counter <= timer_count;
        counting <= 1;
      end
      
      if (counting) begin
        if (counter > 0) begin
          counter <= counter - 1;
        end else begin
          counting <= 0;
          done <= 1;
        end
      end
      
      if (!counting && ack) begin
        done <= 0;
      end
    end
  end
  
  always @(posedge clk) begin
    if (counting) begin
      internal_counter <= internal_counter + 1;
      count <= delay - (internal_counter / 1000);
    end else begin
      internal_counter <= 0;
      count <= 4'b0000;
    end
  end

endmodule
