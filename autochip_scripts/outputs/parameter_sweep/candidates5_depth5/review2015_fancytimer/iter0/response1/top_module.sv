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
    reg [3:0] start_seq;
    reg [3:0] count_temp;
    
    parameter IDLE = 4'b0000;
    parameter DETECT_PATTERN = 4'b0001;
    parameter SHIFT_DELAY = 4'b0010;
    parameter COUNT = 4'b0011;
    parameter WAIT_ACK = 4'b0100;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counting <= 0;
            done <= 0;
            remaining_time <= 4'b0000;
            count_temp <= 4'b0000;
        end else begin
            state <= next_state;
            counting <= (state == COUNT);
            done <= (state == WAIT_ACK && ack);
            remaining_time <= delay - count_temp;
            count <= counting ? remaining_time : 4'bXXXX;
        end
    end
    
    always @(posedge clk) begin
        case (state)
            IDLE: begin
                if (data == 4'b1101) begin
                    start_seq <= 4'b1101;
                    next_state <= DETECT_PATTERN;
                end else begin
                    next_state <= IDLE;
                end
            end
            DETECT_PATTERN: begin
                if (data == start_seq) begin
                    next_state <= SHIFT_DELAY;
                end else begin
                    next_state <= IDLE;
                end
            end
            SHIFT_DELAY: begin
                delay <= data;
                count_temp <= 4'b0000;
                next_state <= COUNT;
            end
            COUNT: begin
                if (count_temp == delay) begin
                    count_temp <= 4'b0000;
                    next_state <= WAIT_ACK;
                end else begin
                    count_temp <= count_temp + 1;
                    next_state <= COUNT;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    next_state <= IDLE;
                end else begin
                    next_state <= WAIT_ACK;
                end
            end
        endcase
    end

endmodule
