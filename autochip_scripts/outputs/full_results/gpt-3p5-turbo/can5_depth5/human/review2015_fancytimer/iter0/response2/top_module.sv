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
    reg [3:0] state;
    reg [3:0] next_state;
    reg [3:0] start_sequence;
    
    parameter IDLE_STATE = 0;
    parameter SEARCH_STATE = 1;
    parameter COUNT_STATE = 2;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            state <= IDLE_STATE;
            counter <= 0;
            delay <= 0;
            remaining_time <= 0;
        end else begin
            case(state)
                IDLE_STATE: begin
                    if (data == 4'b1101) begin
                        state <= SEARCH_STATE;
                        start_sequence <= 4'b1101;
                    end
                end
                SEARCH_STATE: begin
                    state <= COUNT_STATE;
                    delay <= data;
                    counter <= (delay + 1) * 1000;
                    remaining_time <= delay;
                    counting <= 1;
                end
                COUNT_STATE: begin
                    if (counter > 0) begin
                        counter <= counter - 1;
                        if (counter % 1000 == 0) begin
                            remaining_time <= remaining_time - 1;
                        end
                    else begin
                        counting <= 0;
                        done <= 1;
                    end
                end
            endcase
        end
    end
    
    assign count = counting ? remaining_time : 4'bxxxx;
    
    always @(posedge clk) begin
        if (ack) begin
            counting <= 0;
            done <= 0;
            state <= IDLE_STATE;
            counter <= 0;
            delay <= 0;
            remaining_time <= 0;
        end
    end
    
endmodule
