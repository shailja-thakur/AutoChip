module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE        = 3'b000,
        START_BIT   = 3'b001,
        DATA_BITS   = 3'b010,
        STOP_BIT    = 3'b011,
        CHECK_STOP  = 3'b100
    } state_t;

    reg [2:0] state, next_state;
    reg [2:0] bit_counter;
    reg [7:0] data_buffer;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        done = 0;
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 0) begin // Detect start bit (0)
                    next_state = START_BIT;
                end
            end
            START_BIT: begin
                if (in == 0) begin
                    next_state = DATA_BITS;
                end else begin
                    next_state = IDLE; // False start bit
                end
            end
            DATA_BITS: begin
                if (bit_counter < 7) begin
                    next_state = DATA_BITS;
                end else begin
                    next_state = STOP_BIT;
                end
            end
            STOP_BIT: begin
                if (in == 1) begin // Detect stop bit (1)
                    next_state = CHECK_STOP;
                end else begin
                    next_state = IDLE; // Incorrect stop bit, reset
                end
            end
            CHECK_STOP: begin
                done = 1;
                next_state = IDLE;
            end
        endcase
    end

    // Output and counter logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_counter <= 0;
            data_buffer <= 0;
            out_byte <= 0;
        end else begin
            case (state)
                IDLE: begin
                    bit_counter <= 0;
                end
                START_BIT: begin
                    bit_counter <= 0;
                end
                DATA_BITS: begin
                    data_buffer[bit_counter] <= in; // Sample data bit
                    bit_counter <= bit_counter + 1;
                end
                STOP_BIT: begin
                    // Wait for stop bit detection in next_state logic
                end
                CHECK_STOP: begin
                    out_byte <= data_buffer;
                end
            endcase
        end
    end

endmodule
