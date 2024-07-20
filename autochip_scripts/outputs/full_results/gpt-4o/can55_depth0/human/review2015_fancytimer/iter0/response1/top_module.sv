module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    // State encoding
    typedef enum reg [2:0] {
        S_IDLE,         // Initial state
        S_DETECT,       // Detecting start pattern 1101
        S_SHIFT,        // Shifting in the 4-bit delay
        S_COUNT,        // Counting for the delay period
        S_DONE          // Done state, waiting for acknowledgment
    } state_t;

    state_t state, next_state;

    reg [3:0] shift_reg;        // Shift register for detecting pattern and shifting in delay bits
    reg [2:0] bit_counter;      // Counter for the number of bits shifted in
    reg [3:0] delay;            // Holds the delay value
    reg [12:0] cycle_counter;   // Counts 1000 clock cycles

    always @(posedge clk) begin
        if (reset) begin
            state <= S_IDLE;
            shift_reg <= 4'b0;
            bit_counter <= 3'b0;
            delay <= 4'b0;
            count <= 4'b0;
            cycle_counter <= 13'b0;
            counting <= 1'b0;
            done <= 1'b0;
        end
        else begin
            state <= next_state;
            
            case (state)
                S_IDLE: begin
                    shift_reg <= 4'b0;
                    bit_counter <= 3'b0;
                    delay <= 4'b0;
                    count <= 4'b0;
                    cycle_counter <= 13'b0;
                    counting <= 1'b0;
                    done <= 1'b0;
                end

                S_DETECT: begin
                    shift_reg <= {shift_reg[2:0], data};
                    if (shift_reg == 4'b1101)
                        bit_counter <= 3'b100;
                end

                S_SHIFT: begin
                    if (bit_counter != 0) begin
                        shift_reg <= {shift_reg[2:0], data};
                        bit_counter <= bit_counter - 1'b1;
                        delay <= {shift_reg[2:0], data};
                    end
                    else begin
                        count <= delay;
                        counting <= 1'b1;
                    end
                end

                S_COUNT: begin
                    if (cycle_counter != 13'd999) begin
                        cycle_counter <= cycle_counter + 1'b1;
                    end else begin
                        cycle_counter <= 13'b0;
                        if (count != 0) begin
                            count <= count - 1'b1;
                        end else begin
                            counting <= 1'b0;
                            done <= 1'b1;
                        end
                    end
                end

                S_DONE: begin
                    if (ack) begin
                        done <= 1'b0;
                    end
                end
                
                default: begin
                    state <= S_IDLE;
                end
            endcase
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            S_IDLE: begin
                if (reset) begin
                    next_state = S_IDLE;
                end else if (shift_reg == 4'b1101) begin
                    next_state = S_SHIFT;
                end else begin
                    next_state = S_DETECT;
                end
            end

            S_DETECT: begin
                if (shift_reg == 4'b1101) begin
                    next_state = S_SHIFT;
                end
            end

            S_SHIFT: begin
                if (bit_counter == 0) begin
                    next_state = S_COUNT;
                end
            end

            S_COUNT: begin
                if (done) begin
                    next_state = S_DONE;
                end
            end

            S_DONE: begin
                if (ack) begin
                    next_state = S_IDLE;
                end
            end
        endcase
    end

endmodule
