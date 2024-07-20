module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );
    
    reg [3:0] delay;
    reg [3:0] remaining;
    reg [3:0] state;
    reg [3:0] next_state;
    
    // State Definitions
    parameter IDLE = 0;
    parameter DETECT = 1;
    parameter SHIFT_IN = 2;
    parameter COUNTING = 3;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counting <= 0;
            done <= 0;
            remaining <= 0;
        end else begin
            state <= next_state;
            counting <= (state == COUNTING);
            done <= 0;
            remaining <= delay;
        end
    end
    
    always @(posedge clk) begin
        case(state)
            IDLE: begin
                if (data == 1'b1) begin
                    if (data == 4'b1101) begin
                        delay <= data[3:0];
                        next_state <= SHIFT_IN;
                    end else begin
                        delay <= 0;
                        next_state <= IDLE;
                    end
                end
            end
            DETECT: begin
                if (data == 4'b1101) begin
                    delay <= data[3:0];
                    next_state <= SHIFT_IN;
                end else begin
                    delay <= 0;
                    next_state <= IDLE;
                end
            end
            SHIFT_IN: begin
                delay <= data[3:0];
                next_state <= COUNTING;
            end
            COUNTING: begin
                if (remaining > 0) begin
                    delay <= delay - 1;
                    next_state <= COUNTING;
                end else begin
                    delay <= 0;
                    next_state <= IDLE;
                    done <= 1;
                end
            end
        endcase
    end
    
    assign count = counting ? remaining : 4'bxxxx;
    
    always @(posedge clk) begin
        if (done && ack) begin
            done <= 0;
            delay <= 0;
            next_state <= IDLE;
        end
    end

endmodule
