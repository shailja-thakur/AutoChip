module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    
    // State encoding
    typedef enum reg [2:0] {
        IDLE,
        START_BIT,
        DATA_BITS,
        STOP_BIT,
        WAIT_FOR_IDLE
    } state_t;
    state_t state, next_state;
    
    reg [2:0] bit_counter;
    reg [7:0] data_reg;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 3'd0;
            out_byte <= 8'd0;
            done <= 1'b0;
        end
        else begin
            state <= next_state;
            if (state == DATA_BITS) begin
                data_reg[bit_counter] <= in;
                bit_counter <= bit_counter + 1;
            end
            else if (state == STOP_BIT && in == 1) begin
                out_byte <= data_reg;
                done <= 1'b1;
            end
            else if (state != STOP_BIT) begin
                bit_counter <= 3'd0;
                done <= 1'b0;
            end
        end
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in == 0)
                    next_state = START_BIT;
                else
                    next_state = IDLE;
            end
            START_BIT: begin
                next_state = DATA_BITS;
            end
            DATA_BITS: begin
                if (bit_counter == 3'd7)
                    next_state = STOP_BIT;
                else
                    next_state = DATA_BITS;
            end
            STOP_BIT: begin
                if (in == 1)
                    next_state = WAIT_FOR_IDLE;
                else
                    next_state = STOP_BIT;
            end
            WAIT_FOR_IDLE: begin
                if (in == 1)
                    next_state = IDLE;
                else
                    next_state = WAIT_FOR_IDLE;
            end
            default: next_state = IDLE;
        endcase
    end
    
endmodule
