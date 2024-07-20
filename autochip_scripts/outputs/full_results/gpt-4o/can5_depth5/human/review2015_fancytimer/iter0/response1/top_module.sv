module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State encoding
    typedef enum reg [2:0] {
        WAIT_FOR_1101 = 3'b000,
        SHIFT_IN_DELAY = 3'b001,
        COUNT_DOWN = 3'b010,
        WAIT_ACK = 3'b011
    } state_t;
    
    state_t current_state, next_state;
    reg [3:0] delay;
    reg [3:0] bit_counter;
    reg [12:0] counter;  // Ensure counter is big enough for max delay * 1000
    
    assign count = (current_state == COUNT_DOWN) ? counter / 1000 : 4'bxxxx;

    // State transition
    always @(posedge clk) 
    begin
        if (reset)
            current_state <= WAIT_FOR_1101;
        else
            current_state <= next_state;
    end

    // State transition logic
    always @(*)
    begin
        case (current_state)
            WAIT_FOR_1101: 
                next_state = (shift_reg == 4'b1101) ? SHIFT_IN_DELAY : WAIT_FOR_1101;
            SHIFT_IN_DELAY: 
                next_state = (bit_counter == 4) ? COUNT_DOWN : SHIFT_IN_DELAY;
            COUNT_DOWN: 
                next_state = (counter == 0) ? WAIT_ACK : COUNT_DOWN;
            WAIT_ACK: 
                next_state = ack ? WAIT_FOR_1101 : WAIT_ACK;
            default: 
                next_state = WAIT_FOR_1101;
        endcase
    end

    // Sequential and output logic
    always @(posedge clk) 
    begin
        if (reset) 
        begin
            delay <= 0;
            bit_counter <= 0;
            counter <= 0;
            counting <= 0;
            done <= 0;
        end
        else
        begin
            case (current_state)
                WAIT_FOR_1101: begin
                    done <= 0;
                    counting <= 0;
                    if (next_state == SHIFT_IN_DELAY) 
                    begin
                        bit_counter <= 0;
                    end
                end
                SHIFT_IN_DELAY: begin
                    delay[3-bit_counter] <= data;
                    bit_counter <= bit_counter + 1;
                end
                COUNT_DOWN: begin
                    if (bit_counter == 0)
                    begin
                        counter <= (delay + 1) * 1000;
                        bit_counter <= bit_counter + 1;
                        counting <= 1;
                    end
                    else 
                    begin
                        if (counter > 0)
                            counter <= counter - 1;
                    end
                end
                WAIT_ACK: begin
                    counting <= 0;
                    done <= 1;
                end
            endcase
        end
    end
endmodule
