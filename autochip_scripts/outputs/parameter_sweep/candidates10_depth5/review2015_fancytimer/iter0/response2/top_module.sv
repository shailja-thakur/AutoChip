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
    reg [3:0] shift_reg;
    reg [3:0] state;
    
    parameter IDLE = 3'b000;
    parameter DETECT_START = 3'b001;
    parameter SHIFT_IN_DELAY = 3'b010;
    parameter COUNTING = 3'b011;
    parameter TIMER_DELAY = 3'b100;
    parameter NOTIFY_USER = 3'b101;
    
    initial begin
        counting = 0;
        done = 0;
        state = IDLE;
        delay = 0;
        counter = 0;
        remaining_time = 0;
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            state <= IDLE;
            delay <= 0;
            counter <= 0;
            remaining_time <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (data == 1'b1) begin
                        shift_reg <= {shift_reg[2:0], data};
                        if (shift_reg == 4'b1101) begin
                            state <= DETECT_START;
                        end
                    end
                end
                
                DETECT_START: begin
                    counting <= 0;
                    done <= 0;
                    state <= SHIFT_IN_DELAY;
                    delay <= 0;
                    counter <= 0;
                    remaining_time <= delay;
                end
                
                SHIFT_IN_DELAY: begin
                    counting <= 0;
                    done <= 0;
                    state <= COUNTING;
                    delay <= {shift_reg[3:0], data};
                    counter <= 0;
                    remaining_time <= delay;
                end
                
                COUNTING: begin
                    counting <= 1;
                    done <= 0;
                    state <= TIMER_DELAY;
                    counter <= counter + 1;
                    remaining_time <= delay - counter;
                end
                
                TIMER_DELAY: begin
                    counting <= 0;
                    done <= 0;
                    if (counter == delay) begin
                        state <= NOTIFY_USER;
                    end
                end
                
                NOTIFY_USER: begin
                    counting <= 0;
                    done <= 1;
                    if (ack) begin
                        state <= IDLE;
                    end
                end
                
                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end
    
    assign count = counting ? remaining_time : 4'bxxxx;
    
endmodule
