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
    
    // State machine definition
    localparam IDLE = 1'b0;
    localparam START = 1'b1;
    localparam COUNTING = 1'b2;
    localparam DONE = 1'b3;
    
    reg [1:0] state;
    reg [3:0] counter;
    
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            case(state)
                IDLE: begin
                    if (data == 1 && $past(data) == 1 && $past($past(data)) == 0 && $past($past($past(data))) == 1) begin
                        state <= START;
                        delay <= data;
                    end else begin
                        state <= IDLE;
                        count_reg <= 0;
                        counting <= 0;
                        done <= 0;
                    end
                end
                START: begin
                    state <= COUNTING;
                    counter <= (delay + 1) * 1000 - 1;
                    count_reg <= delay;
                    counting <= 1;
                    done <= 0;
                end
                COUNTING: begin
                    if (counter > 0) begin
                        counter <= counter - 1;
                        if (counter % 1000 == 0) begin
                            count_reg <= count_reg - 1;
                        end
                        remaining_time <= count_reg;
                        counting <= 1;
                        done <= 0;
                    end else begin
                        state <= DONE;
                        counting <= 0;
                        done <= 1;
                    end
                end
                DONE: begin
                    if (ack == 1) begin
                        state <= IDLE;
                        counter <= 0;
                        count_reg <= 0;
                        remaining_time <= 0;
                        counting <= 0;
                        done <= 0;
                    end else begin
                        state <= DONE;
                        counter <= 0;
                        count_reg <= 0;
                        remaining_time <= 0;
                        counting <= 0;
                        done <= 1;
                    end
                end
                default: state <= IDLE;
            endcase
        end
    end
    
    assign count = counting ? count_reg : 4'dx;
    
endmodule
