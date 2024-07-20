module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State declaration
    typedef enum reg [3:0] {
        IDLE, START, DATA_0, DATA_1, DATA_2, DATA_3, DATA_4, DATA_5, DATA_6, DATA_7, STOP, ERROR
    } state_t;
    
    state_t state, next_state;
    reg [7:0] data_reg;
    reg [3:0] bit_counter;
    
    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic and output logic
    always @(*) begin
        next_state = state;
        done = 0;
        case (state)

            IDLE: begin
                if (in == 0) // Detect start bit
                    next_state = START;
            end

            START: begin
                next_state = DATA_0;
            end

            DATA_0: begin
                data_reg[0] = in;
                next_state = DATA_1;
            end

            DATA_1: begin
                data_reg[1] = in;
                next_state = DATA_2;
            end

            DATA_2: begin
                data_reg[2] = in;
                next_state = DATA_3;
            end

            DATA_3: begin
                data_reg[3] = in;
                next_state = DATA_4;
            end

            DATA_4: begin
                data_reg[4] = in;
                next_state = DATA_5;
            end

            DATA_5: begin
                data_reg[5] = in;
                next_state = DATA_6;
            end

            DATA_6: begin
                data_reg[6] = in;
                next_state = DATA_7;
            end

            DATA_7: begin
                data_reg[7] = in;
                next_state = STOP;
            end

            STOP: begin
                if (in == 1) begin
                    out_byte = data_reg;
                    done = 1;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end

            ERROR: begin
                if (in == 1)
                    next_state = IDLE;
            end

        endcase
    end
    
endmodule
