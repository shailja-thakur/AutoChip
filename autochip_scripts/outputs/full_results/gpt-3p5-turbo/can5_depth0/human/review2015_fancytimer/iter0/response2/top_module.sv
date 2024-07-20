module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] counter;
    reg [3:0] remaining_time;
    
    localparam IDLE = 2'd0;
    localparam DETECT_PATTERN = 2'd1;
    localparam SHIFT_IN_DELAY = 2'd2;
    localparam COUNTING = 2'd3;
    localparam TIMER_DONE = 2'd4;
    
    reg [1:0] state;
    reg [2:0] shift_count;
    
    always @(posedge clk) begin
        if(reset) begin
            state <= IDLE;
            shift_count <= 3'b0;
            delay <= 4'b0;
            counter <= 4'b0;
            counting <= 0;
            done <= 0;
            remaining_time <= 4'b0;
        end
        else begin
            case(state)
	            IDLE: begin
	                if(data == 1'b1) begin
	                    if(shift_count == 3'b0 && data == 1'b1) begin
	                        if(counting) begin
	                            if(remaining_time == 4'b0) begin
	                                done <= 1;
	                                if(ack == 1'b1) begin
	                                    state <= DETECT_PATTERN;
	                                end
	                            end
	                            else begin
	                                remaining_time <= remaining_time - 1;
	                            end
	                        end
	                        else begin
	                            state <= DETECT_PATTERN;
	                        end
	                    end
	                    else if(shift_count != 3'b0) begin
	                        delay[shift_count] <= data;
	                        shift_count <= shift_count - 1;
	                    end
	                end
	            end
	            DETECT_PATTERN: begin
	                if({data, counter} == 8'b1101) begin
	                    shift_count <= 3'b11;
	                    state <= SHIFT_IN_DELAY;
	                end
	            end
	            SHIFT_IN_DELAY: begin
	                if(shift_count != 3'b0) begin
	                    delay[shift_count] <= data;
	                    shift_count <= shift_count - 1;
	                end
	                else begin
	                    counting <= 1;
	                    state <= COUNTING;
	                end
	            end
	            COUNTING: begin
	                if(counter != (delay + 1) * 1000 - 1) begin
	                    counter <= counter + 1;
                        if((counter + 1) % 1000 == 0) begin
                            remaining_time <= delay - (counter + 1) / 1000;
                        end
	                end
	                else begin
	                    counting <= 0;
	                    done <= 1;
	                    state <= TIMER_DONE;
	                end
	            end
	            TIMER_DONE: begin
	            	if(ack == 1'b1) begin
	                    done <= 0;
	                    state <= IDLE;
	                end
	            end
	        endcase
        end
    end
    
    assign count = counting ? remaining_time : 4'bZ;
    
endmodule
