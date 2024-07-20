module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State declarations
    typedef enum reg [3:0] {
        IDLE = 4'b0000,
        START_BIT = 4'b0001,
        DATA_BIT_0 = 4'b0010,
        DATA_BIT_1 = 4'b0011,
        DATA_BIT_2 = 4'b0100,
        DATA_BIT_3 = 4'b0101,
        DATA_BIT_4 = 4'b0110,
        DATA_BIT_5 = 4'b0111,
        DATA_BIT_6 = 4'b1000,
        DATA_BIT_7 = 4'b1001,
        STOP_BIT = 4'b1010,
        STOP_ERROR = 4'b1011
    } state_t;
    
    state_t state, next_state;
    reg [7:0] byte_shift;
    reg [2:0] bit_counter;
    
    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            byte_shift <= 8'b0;
            bit_counter <= 3'b0;
            out_byte <= 8'b0;
            done <= 1'b0;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always @(*) begin
        next_state = state; // Default stay in the current state
        done = 1'b0; // Default done to 0
        
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START_BIT;
                end
            end
            START_BIT: begin
                next_state = DATA_BIT_0;
            end
            DATA_BIT_0: begin
                byte_shift[0] = in;
                next_state = DATA_BIT_1;
            end
            DATA_BIT_1: begin
                byte_shift[1] = in;
                next_state = DATA_BIT_2;
            end
            DATA_BIT_2: begin
                byte_shift[2] = in;
                next_state = DATA_BIT_3;
            end
            DATA_BIT_3: begin
                byte_shift[3] = in;
                next_state = DATA_BIT_4;
            end
            DATA_BIT_4: begin
                byte_shift[4] = in;
                next_state = DATA_BIT_5;
            end
            DATA_BIT_5: begin
                byte_shift[5] = in;
                next_state = DATA_BIT_6;
            end
            DATA_BIT_6: begin
                byte_shift[6] = in;
                next_state = DATA_BIT_7;
            end
            DATA_BIT_7: begin
                byte_shift[7] = in;
                next_state = STOP_BIT;
            end
            STOP_BIT: begin
                if (in == 1'b1) begin
                    out_byte = byte_shift;
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = STOP_ERROR;
                end
            end
            STOP_ERROR: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end
            end
        endcase
    end
    
endmodule
