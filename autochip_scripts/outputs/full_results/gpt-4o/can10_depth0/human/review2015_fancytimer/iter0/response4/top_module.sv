module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    // State declaration
    typedef enum reg [2:0] {
        IDLE,
        CHECK_PATTERN,
        LOAD_DELAY,
        COUNTING,
        DONE
    } state_t;
    state_t state, next_state;

    reg [2:0] bit_count;   // Bit position counter
    reg [3:0] shift_reg;   // Shift register for pattern recognition and delay loading
    reg [15:0] delay_counter; // Counter for counting cycles
    reg [3:0] delay;       // Delay value extracted from data stream
    reg [15:0] target_count; // Target count value in clock cycles

    // State transition logic
    always @ (posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and outputs
    always @(*) begin
        // Default values
        next_state = state;
        counting = 0;
        done = 0;

        case (state)
            IDLE: begin
                if (!reset && bit_count == 3'b100 && shift_reg[3:0] == 4'b1101) begin
                    next_state = LOAD_DELAY;
                end
            end

            CHECK_PATTERN: begin
                if (bit_count == 3'b100) begin
                    if (shift_reg[3:0] == 4'b1101) begin
                        next_state = LOAD_DELAY;
                    end else begin
                        bit_count = 0;
                    end
                end
            end

            LOAD_DELAY: begin
                if (bit_count == 3'd4) begin
                    delay = shift_reg[3:0];
                    target_count = ((delay + 1) * 16'd1000);
                    next_state = COUNTING;
                end
            end

            COUNTING: begin
                counting = 1;
                if (delay_counter == 16'd0) begin
                    next_state = DONE;
                end
                count = delay_counter[3:0];
            end

            DONE: begin
                done = 1;
                if (ack) begin
                    next_state = IDLE;
                    delay_counter = 0;
                end
            end
        endcase
    end

    // Counter and shift register management
    always @(posedge clk) begin
        if (reset) begin
            bit_count <= 0;
            shift_reg <= 0;
            delay_counter <= 0;
            count <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (data) begin
                        shift_reg <= {shift_reg[2:0], data};
                        bit_count <= bit_count + 1;
                    end
                end

                CHECK_PATTERN: begin
                    shift_reg <= {shift_reg[2:0], data};
                    bit_count <= bit_count + 1;
                end

                LOAD_DELAY: begin
                    shift_reg <= {shift_reg[2:0], data};
                    bit_count <= bit_count + 1;
                end

                COUNTING: begin
                    if (delay_counter > 0) begin
                        delay_counter <= delay_counter - 1;
                        if (delay_counter % 1000 == 0) begin
                            delay <= delay - 1;
                        end
                    end
                end
            endcase
        end
    end

endmodule
