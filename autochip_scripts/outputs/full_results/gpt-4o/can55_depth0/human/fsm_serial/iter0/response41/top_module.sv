module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t current_state, next_state;
    reg [3:0] bit_counter; // To count the 8 data bits

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 4'd0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE: begin
                if (in == 1'b0) 
                    next_state = START;
                else
                    next_state = IDLE;
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_counter == 4'd7) 
                    next_state = STOP;
                else
                    next_state = DATA;
            end
            STOP: begin
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = ERROR;
            end
            ERROR: begin
                if (in == 1'b1)
                    next_state = IDLE;
                else
                    next_state = ERROR;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output logic and counter increment
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 1'b0;
            bit_counter <= 4'd0;
        end else begin
            bit_counter <= (current_state == DATA) ? bit_counter + 1 : 4'd0;
            done <= (current_state == STOP && in == 1'b1);
        end
    end

endmodule
