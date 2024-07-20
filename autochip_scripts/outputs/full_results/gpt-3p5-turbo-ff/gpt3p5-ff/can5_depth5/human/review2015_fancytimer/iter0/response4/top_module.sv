module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] count_reg;
    reg [3:0] remaining_time;
    
    reg [3:0] state;
    reg [1:0] pattern;
    
    parameter IDLE = 2'b00;
    parameter DETECT_PATTERN = 2'b01;
    parameter READ_DELAY = 2'b10;
    parameter COUNT = 2'b11;
    
	always @(posedge clk or posedge reset) begin
	   if (reset) begin
	       state <= IDLE;
	       pattern <= 2'b00;
	       delay <= 4'b0000;
	       counting <= 0;
	       done <= 0;
	       count_reg <= 4'b0000;
	       remaining_time <= 4'b0000;
	   end else begin
	       case (state)
	           IDLE:
	               if (data == 1 && pattern == 2'b00) begin
	                   pattern <= 2'b01;
	               end else if (data == 1 && pattern == 2'b01) begin
	                   pattern <= 2'b10;
	               end else if (data == 0 && pattern == 2'b10) begin
	                   pattern <= 2'b11;
	                   state <= DETECT_PATTERN;
	               end else begin
	                   pattern <= 2'b00;
	               end
	           DETECT_PATTERN:
	               if (data == 1 && pattern == 2'b11) begin
	                   pattern <= 2'b00;
	                   state <= READ_DELAY;
	               end else if (data == 1 && pattern != 2'b11) begin
	                   pattern <= 2'b01;
	               end else if (data == 0 && pattern != 2'b11) begin
	                   pattern <= 2'b00;
	               end
	           READ_DELAY:
	               delay <= {delay[2:0], data};
	               state <= COUNT;
	           COUNT:
	               if (count_reg < ((delay + 1) * 1000)) begin
	                   count_reg <= count_reg + 1;
	                   counting <= 1;
	                   remaining_time <= delay - (count_reg / 1000);
	               end else begin
	                   count_reg <= 4'b0000;
	                   counting <= 0;
	                   done <= 1;
	                   state <= IDLE;
	               end
	       endcase
	   end
	end
	
	assign count = count_reg;
    
endmodule
