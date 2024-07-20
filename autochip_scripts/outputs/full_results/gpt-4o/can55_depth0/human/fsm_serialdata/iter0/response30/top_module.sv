module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    // State Declaration
    typedef enum logic [3:0] {
        IDLE,
        START_BIT,
        DATA_BITS_0,
        DATA_BITS_1,
        DATA_BITS_2,
        DATA_BITS_3,
        DATA_BITS_4,
        DATA_BITS_5,
        DATA_BITS_6,
        DATA_BITS_7,
        STOP_BIT,
        CHECK_STOP
    } state_t;

    state_t current_state, next_state;
    reg [7:0] data_byte;
    reg [2:0] bit_counter;

    // State Transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            done <= 0;
            out_byte <= 8'b0;
            data_byte <= 8'b0;
            bit_counter <= 3'b0;
        end else begin
            current_state <= next_state;
            if (next_state == STOP_BIT && current_state == CHECK_STOP) begin
                out_byte <= data_byte;
                done <= 1;
            end else begin
                done <= 0;
            end
        end
    end

    // Next State Logic
    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in == 0) begin
                    next_state = START_BIT;
                end
            end
            START_BIT: begin
                if (in == 0) begin
                    next_state = DATA_BITS_0;
                end else begin
                    next_state = IDLE;
                end
            end
            DATA_BITS_0: begin
                next_state = DATA_BITS_1;
            end
            DATA_BITS_1: begin
                next_state = DATA_BITS_2;
            end
            DATA_BITS_2: begin
                next_state = DATA_BITS_3;
            end
            DATA_BITS_3: begin
                next_state = DATA_BITS_4;
            end
            DATA_BITS_4: begin
                next_state = DATA_BITS_5;
            end
            DATA_BITS_5: begin
                next_state = DATA_BITS_6;
            end
            DATA_BITS_6: begin
                next_state = DATA_BITS_7;
            end
            DATA_BITS_7: begin
                next_state = STOP_BIT;
            end
            STOP_BIT: begin
                if (in == 1) begin
                    next_state = CHECK_STOP;
                end else begin
                    next_state = IDLE;
                end
            end
            CHECK_STOP: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output and Data Byte Capturing
    always_ff @(posedge clk) begin
        if (current_state == IDLE) begin
            bit_counter <= 3'b0;
            data_byte <= 8'b0;
        end else if (current_state >= DATA_BITS_0 && current_state <= DATA_BITS_7) begin
            data_byte[bit_counter] <= in;
            bit_counter <= bit_counter + 1;
        end
    end

endmodule
