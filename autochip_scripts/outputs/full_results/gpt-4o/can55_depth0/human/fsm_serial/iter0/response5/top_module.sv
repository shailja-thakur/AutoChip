module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State declaration
    typedef enum reg [3:0] {
        IDLE     = 4'b0000,
        START    = 4'b0001,
        BIT_0    = 4'b0010,
        BIT_1    = 4'b0011,
        BIT_2    = 4'b0100,
        BIT_3    = 4'b0101,
        BIT_4    = 4'b0110,
        BIT_5    = 4'b0111,
        BIT_6    = 4'b1000,
        BIT_7    = 4'b1001,
        STOP     = 4'b1010
    } state_t;

    // State and data registers
    reg [3:0] state, next_state;
    reg [7:0] data;
    reg bit_counter;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 0;
        end
        else begin
            state <= next_state;
            if (state == START || state == BIT_0 || state == BIT_1 || 
                state == BIT_2 || state == BIT_3 || state == BIT_4 || 
                state == BIT_5 || state == BIT_6 || state == BIT_7) begin
                bit_counter <= bit_counter + 1;
                data[bit_counter] <= in;  // Shift data bits in, LSB first
            end
            else 
                bit_counter <= 0;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (in == 0) // Start bit detected
                    next_state = START;
                else
                    next_state = IDLE;
            end
            START: begin
                next_state = BIT_0;
            end
            BIT_0: begin
                next_state = BIT_1;
            end
            BIT_1: begin
                next_state = BIT_2;
            end
            BIT_2: begin
                next_state = BIT_3;
            end
            BIT_3: begin
                next_state = BIT_4;
            end
            BIT_4: begin
                next_state = BIT_5;
            end
            BIT_5: begin
                next_state = BIT_6;
            end
            BIT_6: begin
                next_state = BIT_7;
            end
            BIT_7: begin
                if (bit_counter == 7)
                    next_state = STOP;
                else
                    next_state = state;
            end
            STOP: begin
                if (in == 1) begin // Stop bit detected
                    done = 1;
                    next_state = IDLE;
                end
                else
                    next_state = STOP;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Done signal logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            done <= 0;
        else if (state == STOP && in == 1)
            done <= 1;
        else
            done <= 0;
    end
endmodule
