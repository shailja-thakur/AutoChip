module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum reg [3:0] {
        IDLE       = 4'b0000,
        START_BIT  = 4'b0001,
        BIT0       = 4'b0010,
        BIT1       = 4'b0011,
        BIT2       = 4'b0100,
        BIT3       = 4'b0101,
        BIT4       = 4'b0110,
        BIT5       = 4'b0111,
        BIT6       = 4'b1000,
        BIT7       = 4'b1001,
        STOP_BIT   = 4'b1010,
        VERIFY     = 4'b1011
    } state_t;
    
    state_t current_state, next_state;

    // Data shift register
    reg [7:0] data_shift;
    reg [3:0] bit_counter;

    // State Transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next State Logic
    always @(*) begin
        case (current_state)
            IDLE: begin
                if (in == 1'b0)
                    next_state = START_BIT;
                else
                    next_state = IDLE;
            end
            START_BIT: begin
                next_state = BIT0;
            end
            BIT0: next_state = BIT1;
            BIT1: next_state = BIT2;
            BIT2: next_state = BIT3;
            BIT3: next_state = BIT4;
            BIT4: next_state = BIT5;
            BIT5: next_state = BIT6;
            BIT6: next_state = BIT7;
            BIT7: next_state = STOP_BIT;
            STOP_BIT: begin
                if (in == 1'b1)
                    next_state = VERIFY;
                else
                    next_state = IDLE;
            end
            VERIFY: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output and Data Register Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 0;
            data_shift <= 8'b0;
            out_byte <= 8'b0;
            bit_counter <= 4'b0;
        end else begin
            done <= 0; // Reset done signal every clock

            case (current_state)
                IDLE: begin
                    done <= 0;
                    data_shift <= 8'b0;
                    bit_counter <= 4'b0;
                end
                START_BIT: begin
                    // Do nothing, just move to next state
                end
                BIT0: begin
                    data_shift[0] <= in;
                    bit_counter <= bit_counter + 1;
                end
                BIT1: begin
                    data_shift[1] <= in;
                    bit_counter <= bit_counter + 1;
                end
                BIT2: begin
                    data_shift[2] <= in;
                    bit_counter <= bit_counter + 1;
                end
                BIT3: begin
                    data_shift[3] <= in;
                    bit_counter <= bit_counter + 1;
                end
                BIT4: begin
                    data_shift[4] <= in;
                    bit_counter <= bit_counter + 1;
                end
                BIT5: begin
                    data_shift[5] <= in;
                    bit_counter <= bit_counter + 1;
                end
                BIT6: begin
                    data_shift[6] <= in;
                    bit_counter <= bit_counter + 1;
                end
                BIT7: begin
                    data_shift[7] <= in;
                    bit_counter <= bit_counter + 1;
                end
                STOP_BIT: begin
                    // Do nothing, just check stop bit in next cycle
                end
                VERIFY: begin
                    if (in == 1'b1) begin
                        out_byte <= data_shift;
                        done <= 1;
                    end
                end
                default: begin
                    // Default to IDLE state, should not happen
                end
            endcase
        end
    end

endmodule
