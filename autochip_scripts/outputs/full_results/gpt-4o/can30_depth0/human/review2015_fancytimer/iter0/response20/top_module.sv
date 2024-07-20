module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);
    // State encoding
    localparam IDLE = 3'd0;
    localparam DETECT_SEQ = 3'd1;
    localparam READ_DELAY = 3'd2;
    localparam COUNTDOWN = 3'd3;
    localparam WAIT_ACK = 3'd4;

    reg [2:0] state, next_state;
    reg [3:0] pattern;
    reg [3:0] delay;
    reg [11:0] counter; // 12-bit counter to count up to 10000 clock cycles (for delay 15)
    reg [3:0] bits_read;
    
    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            pattern <= 4'b0;
            delay <= 4'b0;
            counter <= 12'b0;
            bits_read <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always @* begin
        next_state = state;
        case (state)
            IDLE: begin
                done = 1'b0;
                counting = 1'b0;
                if (data) begin
                    pattern = {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        next_state = READ_DELAY;
                        bits_read = 0;
                    end else begin
                        next_state = DETECT_SEQ;
                    end
                end
            end
            
            DETECT_SEQ: begin
                pattern = {pattern[2:0], data};
                if (pattern == 4'b1101) begin
                    next_state = READ_DELAY;
                    bits_read = 0;
                end
            end
            
            READ_DELAY: begin
                if (bits_read < 4) begin
                    delay = {delay[2:0], data};
                    bits_read = bits_read + 1;
                end else begin
                    next_state = COUNTDOWN;
                    counter = (delay + 1) * 1000 - 1;
                end
            end
            
            COUNTDOWN: begin
                counting = 1'b1;
                if (counter == 0) begin
                    next_state = WAIT_ACK;
                    done = 1'b1;
                end else begin
                    counter = counter - 1;
                end
            end
            
            WAIT_ACK: begin
                counting = 1'b0;
                if (ack) begin
                    next_state = IDLE;
                end
            end
        endcase
    end
    
    // Counting down displaying logic
    assign count = counting ? counter[11:8] : 4'bxxxx;
    
endmodule
