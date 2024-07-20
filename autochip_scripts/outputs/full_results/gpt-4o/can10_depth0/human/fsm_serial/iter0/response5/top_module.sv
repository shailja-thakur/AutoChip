module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State declaration
    typedef enum logic [3:0] {
        IDLE = 4'd0,
        START_BIT = 4'd1,
        DATA_BIT_0 = 4'd2,
        DATA_BIT_1 = 4'd3,
        DATA_BIT_2 = 4'd4,
        DATA_BIT_3 = 4'd5,
        DATA_BIT_4 = 4'd6,
        DATA_BIT_5 = 4'd7,
        DATA_BIT_6 = 4'd8,
        DATA_BIT_7 = 4'd9,
        STOP_BIT = 4'd10,
        ERROR = 4'd11
    } state_t;

    state_t current_state, next_state;
    reg [2:0] data_bit_counter;

    // State transition logic (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            data_bit_counter <= 3'd0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic (combinational)
    always @(*) begin
        // Default assignments
        next_state = current_state;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START_BIT;
                end
            end

            START_BIT: begin
                next_state = DATA_BIT_0;
            end

            DATA_BIT_0: begin
                next_state = DATA_BIT_1;
            end

            DATA_BIT_1: begin
                next_state = DATA_BIT_2;
            end

            DATA_BIT_2: begin
                next_state = DATA_BIT_3;
            end

            DATA_BIT_3: begin
                next_state = DATA_BIT_4;
            end

            DATA_BIT_4: begin
                next_state = DATA_BIT_5;
            end

            DATA_BIT_5: begin
                next_state = DATA_BIT_6;
            end

            DATA_BIT_6: begin
                next_state = DATA_BIT_7;
            end

            DATA_BIT_7: begin
                next_state = STOP_BIT;
            end

            STOP_BIT: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                    done = 1'b1;
                end else begin
                    next_state = ERROR;
                end
            end

            ERROR: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end
            end

            // Default case should never be reached
            default: next_state = IDLE;
        endcase
    end

endmodule
