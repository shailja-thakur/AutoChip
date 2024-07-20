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
        IDLE    = 3'b000,
        DETECT  = 3'b001,
        LOAD    = 3'b010,
        COUNT   = 3'b011,
        WAIT_ACK= 3'b100
    } state_t;

    state_t state, next_state;
    reg [3:0] delay;
    reg [2:0] bit_counter;
    reg [12:0] cycle_counter;  // Enough to count to 8000

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (reset)
                    next_state = DETECT;
            end
            DETECT: begin
                if (data == 1 && bit_counter == 3)
                    next_state = LOAD;
            end
            LOAD: begin
                if (bit_counter == 7)
                    next_state = COUNT;
            end
            COUNT: begin
                if (cycle_counter == 0 && count == 0)
                    next_state = WAIT_ACK;
            end
            WAIT_ACK: begin
                if (ack)
                    next_state = IDLE;
            end
        endcase
    end

    // Output and counters control logic
    always @(posedge clk) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            count <= 0;
            delay <= 0;
            bit_counter <= 0;
            cycle_counter <= 0;
        end else begin
            case (state)
                IDLE: begin
                    counting <= 0;
                    done <= 0;
                    bit_counter <= 0;
                    cycle_counter <= 0;
                    count <= 4'bxxxx; // Don't care
                end
                DETECT: begin
                    // Shift in 1101 detection
                    if (bit_counter < 3) begin
                        if (data == (4'b1101 >> bit_counter)[0])
                            bit_counter <= bit_counter + 1;
                        else
                            bit_counter <= 0;
                    end
                end
                LOAD: begin
                    // Shift in delay
                    delay <= {delay[2:0], data};
                    bit_counter <= bit_counter + 1;
                    if (bit_counter == 7)
                        count <= delay;
                end
                COUNT: begin
                    counting <= 1;
                    if (cycle_counter == 13'h3E8) begin // 1000 cycles
                        cycle_counter <= 0;
                        if (count > 0)
                            count <= count - 1;
                    end else begin
                        cycle_counter <= cycle_counter + 1;
                    end
                end
                WAIT_ACK: begin
                    counting <= 0;
                    done <= 1;
                    if (ack) begin
                        done <= 0;
                    end
                end
            endcase
        end
    end
endmodule
