module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State definitions
    typedef enum reg [3:0] {
        IDLE,
        START,
        BIT0,
        BIT1,
        BIT2,
        BIT3,
        BIT4,
        BIT5,
        BIT6,
        BIT7,
        STOP,
        ERROR
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data_byte;

    // State transition logic
    always @(*) begin
        next_state = state;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (!in) begin // Detect start bit
                    next_state = START;
                end
            end
            START: begin
                next_state = BIT0;
            end
            BIT0: begin
                data_byte[0] = in;
                next_state = BIT1;
            end
            BIT1: begin
                data_byte[1] = in;
                next_state = BIT2;
            end
            BIT2: begin
                data_byte[2] = in;
                next_state = BIT3;
            end
            BIT3: begin
                data_byte[3] = in;
                next_state = BIT4;
            end
            BIT4: begin
                data_byte[4] = in;
                next_state = BIT5;
            end
            BIT5: begin
                data_byte[5] = in;
                next_state = BIT6;
            end
            BIT6: begin
                data_byte[6] = in;
                next_state = BIT7;
            end
            BIT7: begin
                data_byte[7] = in;
                next_state = STOP;
            end
            STOP: begin
                if (in) begin // Verify stop bit
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in) begin // Wait for idle
                    next_state = IDLE;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // State and bit counting register update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'b0;
            data_byte <= 8'b0;
        end else begin
            state <= next_state;
            if (state == IDLE && !in) begin
                bit_count <= 3'b0;
            end else if (state >= BIT0 && state <= BIT7) begin
                bit_count <= bit_count + 1'b1;
            end
        end
    end

endmodule
