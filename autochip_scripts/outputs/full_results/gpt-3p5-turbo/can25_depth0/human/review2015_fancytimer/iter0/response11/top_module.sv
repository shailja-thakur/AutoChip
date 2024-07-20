module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
    
    reg [3:0] delay;
    
    // Define states
    parameter [3:0] IDLE = 4'b0000;  // Idle state
    parameter [3:0] SEARCH = 4'b0001;  // Searching for start sequence state
    parameter [3:0] SHIFT = 4'b0010;  // Shifting in delay value state
    parameter [3:0] COUNT = 4'b0011;  // Counting state
    parameter [3:0] FINISH = 4'b0100;  // Timer finished state
    
    // Define signals
    reg [3:0] state;
    reg [3:0] count_value;
    reg [3:0] remaining_time;
    
    // State machine
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counting <= 0;
            done <= 0;
            remaining_time <= 0;
        end else begin
            case(state)
                IDLE: begin
                    if (data == 4'b1101) begin
                        state <= SHIFT;
                        counting <= 0;
                        done <= 0;
                        count_value <= 0;
                        delay <= 0;
                        remaining_time <= 0;
                    end else begin
                        state <= IDLE;
                        counting <= 0;
                        done <= 0;
                        count_value <= 0;
                        delay <= 0;
                        remaining_time <= 0;
                    end
                end
                SHIFT: begin
                    if (count_value == 4'b1111) begin
                        state <= COUNT;
                        counting <= 1;
                        done <= 0;
                        count_value <= 0;
                        delay <= data;
                        remaining_time <= delay;
                    end else begin
                        state <= SHIFT;
                        counting <= 0;
                        done <= 0;
                        count_value <= count_value + 1;
                        delay <= 0;
                        remaining_time <= 0;
                    end
                end
                COUNT: begin
                    if (remaining_time == 0) begin
                        state <= FINISH;
                        counting <= 0;
                        done <= 1;
                        count_value <= 0;
                        delay <= 0;
                        remaining_time <= 0;
                    end else begin
                        state <= COUNT;
                        counting <= 1;
                        done <= 0;
                        count_value <= count_value + 1;
                        delay <= delay;
                        remaining_time <= remaining_time - 1;
                    end
                end
                FINISH: begin
                    if (ack == 1) begin
                        state <= IDLE;
                        counting <= 0;
                        done <= 0;
                        count_value <= 0;
                        delay <= 0;
                        remaining_time <= 0;
                    end else begin
                        state <= FINISH;
                        counting <= 0;
                        done <= 1;
                        count_value <= count_value;
                        delay <= delay;
                        remaining_time <= remaining_time;
                    end
                end
                default: begin
                    state <= IDLE;
                    counting <= 0;
                    done <= 0;
                    count_value <= 0;
                    delay <= 0;
                    remaining_time <= 0;
                end
            endcase
        end
    end
    
    // Output assignment
    assign count = count_value;
    
endmodule
