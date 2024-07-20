module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    typedef enum logic [2:0] {
        SEARCH_PATTERN = 3'b000,
        LOAD_DELAY     = 3'b001,
        COUNT_DOWN     = 3'b010,
        WAIT_ACK       = 3'b011
    } state_t;

    state_t state, next_state;
    reg [3:0] delay;
    reg [3:0] bit_counter;
    reg [12:0] timer_counter;
    reg [3:0] delay_latch;

    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            state <= SEARCH_PATTERN;
            bit_counter <= 0;
            delay <= 0;
            timer_counter <= 0;
            count <= 4'bxxxx;
            counting <= 0;
            done <= 0;
        end
        else begin
            state <= next_state;
            
            case(state)
                SEARCH_PATTERN: begin
                    if(data == 1'b1) bit_counter <= bit_counter + 1;
                    else bit_counter <= 0;
                    
                    if(bit_counter == 4) begin
                        case(data)
                            4'b1101: next_state <= LOAD_DELAY;
                            default: next_state <= SEARCH_PATTERN;
                        endcase
                    end
                    else next_state <= SEARCH_PATTERN;
                end

                LOAD_DELAY: begin
                    delay <= {delay[2:0], data};
                    bit_counter <= bit_counter + 1;
                    
                    if(bit_counter == 3) begin
                        delay_latch <= {delay[2:0], data};
                        next_state <= COUNT_DOWN;
                    end
                    else next_state <= LOAD_DELAY;
                end

                COUNT_DOWN: begin
                    counting <= 1;
                    timer_counter <= timer_counter + 1'b1;
                    if(timer_counter == 1000) begin
                        if(count == 0) begin
                            counting <= 0;
                            next_state <= WAIT_ACK;
                        end
                        else begin
                            count <= count - 1;
                            timer_counter <= 0;
                        end
                    end
                    else next_state <= COUNT_DOWN;
                end

                WAIT_ACK: begin
                    done <= 1;
                    if(ack) begin
                        done <= 0;
                        next_state <= SEARCH_PATTERN;
                    end
                    else next_state <= WAIT_ACK;
                end
            endcase
        end
    end

    always_ff @(posedge clk or posedge reset) begin
        if(reset) count <= 0;
        else if(state == COUNT_DOWN) count <= delay_latch;
    end

endmodule
