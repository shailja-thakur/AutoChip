module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State enumeration
    typedef enum reg [3:0] {
        IDLE           = 4'b0000,
        PATTERN_DETECT = 4'b0001,
        LOAD_DELAY     = 4'b0010,
        COUNT          = 4'b0011,
        WAIT_ACK       = 4'b0100
    } state_t;
    
    reg [3:0] current_state, next_state;
    reg [3:0] bit_counter;
    reg [3:0] delay;
    reg [15:0] timer;
    
    always @(posedge clk) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            counting <= 1'b0;
            done <= 1'b0;
            bit_counter <= 4'd0;
            delay <= 4'd0;
            timer <= 16'd0;
        end else begin
            case (current_state)
                IDLE: begin
                    counting <= 1'b0;
                    done <= 1'b0;
                    bit_counter <= 4'd0;
                    delay <= 4'd0;
                    timer <= 16'd0;
                end
                PATTERN_DETECT: begin
                    if (bit_counter < 4) begin
                        if (data == (4'b1101 >> (3-bit_counter)) & 1) begin
                            bit_counter <= bit_counter + 1;
                        end else begin
                            next_state <= IDLE;
                        end
                    end
                end
                LOAD_DELAY: begin
                    if (bit_counter < 8) begin
                        delay[3-(bit_counter-4)] <= data;
                        bit_counter <= bit_counter + 1;
                    end else begin
                        timer <= (delay + 1) * 1000;
                        next_state <= COUNT;
                    end
                end
                COUNT: begin
                    if (timer > 0) begin
                        timer <= timer - 1;
                        counting <= 1'b1;
                        done <= 1'b0;
                    end else begin
                        counting <= 1'b0;
                        done <= 1'b1;
                        next_state <= WAIT_ACK;
                    end
                end
                WAIT_ACK: begin
                    if (ack) begin
                        next_state <= IDLE;
                    end
                end
            endcase
            
            if (current_state == COUNT) begin
                count <= timer / 1000;
            end else begin
                count <= 4'bxxxx;
            end
        end
    end

    always @* begin
        case (current_state)
            IDLE: next_state = !reset ? PATTERN_DETECT : IDLE;
            PATTERN_DETECT: next_state = (bit_counter == 4) ? LOAD_DELAY : PATTERN_DETECT;
            LOAD_DELAY: next_state = (bit_counter == 8) ? COUNT : LOAD_DELAY;
            COUNT: next_state = (timer == 0) ? WAIT_ACK : COUNT;
            WAIT_ACK: next_state = ack ? IDLE : WAIT_ACK;
            default: next_state = IDLE;
        endcase
    end

endmodule
