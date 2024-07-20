module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] remaining_time;
    reg [3:0] state;
    reg [3:0] next_state;
    
    parameter IDLE = 4'b0000;
    parameter START = 4'b0001;
    parameter COUNTING = 4'b0010;
    parameter DONE = 4'b0011;
    
    always @(posedge clk) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            delay <= 0;
            remaining_time <= 0;
            state <= IDLE;
        end else begin
            counting <= (state == COUNTING);
            done <= (state == DONE);
            
            case (state)
                IDLE: begin
                    if (data == 1'b1 && $fell(data) == 1'b1) begin
                        state <= START;
                    end
                end
                START: begin
                    delay <= {data, delay[3:1]};
                    remaining_time <= delay;
                    state <= COUNTING;
                end
                COUNTING: begin
                    if (remaining_time > 0) begin
                        remaining_time <= remaining_time - 1;
                    end else begin
                        remaining_time <= delay;
                        state <= DONE;
                    end
                end
                DONE: begin
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
    
    assign count = (state == COUNTING) ? remaining_time : 4'bzzzz;
    
endmodule
