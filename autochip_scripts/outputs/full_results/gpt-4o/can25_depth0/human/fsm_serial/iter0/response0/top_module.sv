module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum logic [3:0] {
        IDLE = 4'b0000,
        START = 4'b0001,
        DATA_BIT_0 = 4'b0010,
        DATA_BIT_1 = 4'b0011,
        DATA_BIT_2 = 4'b0100,
        DATA_BIT_3 = 4'b0101,
        DATA_BIT_4 = 4'b0110,
        DATA_BIT_5 = 4'b0111,
        DATA_BIT_6 = 4'b1000,
        DATA_BIT_7 = 4'b1001,
        STOP = 4'b1010,
        ERROR = 4'b1011
    } state_t;
    
    state_t current_state, next_state;
    reg [7:0] data_byte;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 0;
        end
        else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = current_state;  // Default to no state change
        done = 0;                    // Default to not done

        case (current_state)
            IDLE: begin
                if (in == 0)
                    next_state = START;
            end
            START: begin
                next_state = DATA_BIT_0;
            end
            DATA_BIT_0: next_state = DATA_BIT_1;
            DATA_BIT_1: next_state = DATA_BIT_2;
            DATA_BIT_2: next_state = DATA_BIT_3;
            DATA_BIT_3: next_state = DATA_BIT_4;
            DATA_BIT_4: next_state = DATA_BIT_5;
            DATA_BIT_5: next_state = DATA_BIT_6;
            DATA_BIT_6: next_state = DATA_BIT_7;
            DATA_BIT_7: next_state = STOP;
            STOP: begin
                if (in == 1) begin
                    next_state = IDLE;
                    done = 1;  // Byte received correctly
                end
                else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1)
                    next_state = IDLE;
            end
        endcase
    end

    // Data bit shift register
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            data_byte <= 8'b0;
        end
        else begin
            case (current_state)
                DATA_BIT_0: data_byte[0] <= in;
                DATA_BIT_1: data_byte[1] <= in;
                DATA_BIT_2: data_byte[2] <= in;
                DATA_BIT_3: data_byte[3] <= in;
                DATA_BIT_4: data_byte[4] <= in;
                DATA_BIT_5: data_byte[5] <= in;
                DATA_BIT_6: data_byte[6] <= in;
                DATA_BIT_7: data_byte[7] <= in;
                default: data_byte <= data_byte;  // Hold current value
            endcase
        end
    end

endmodule
