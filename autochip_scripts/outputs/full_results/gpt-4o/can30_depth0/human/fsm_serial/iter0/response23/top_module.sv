module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State declaration
    typedef enum logic [2:0] {
        IDLE,
        START,
        DATA,
        STOP,
        ERROR
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count; // To count the 8 data bits
    reg [7:0] data; // To store the 8 data bits

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = state; // Default to no state change
        done = 0; // Default to not done

        case (state)
            IDLE: begin
                if (in == 0)
                    next_state = START;
            end

            START: begin
                if (in == 0)
                    next_state = DATA;
                else
                    next_state = IDLE;
                bit_count = 0;
            end

            DATA: begin
                if (bit_count == 7)
                    next_state = STOP;
                else
                    bit_count = bit_count + 1;
            end

            STOP: begin
                if (in == 1) begin
                    done = 1;
                    next_state = IDLE;
                end
                else
                    next_state = ERROR;
            end

            ERROR: begin
                if (in == 1)
                    next_state = IDLE;
            end
        endcase
    end

    // Data bit capture
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            data <= 8'b0;
        end
        else if (state == DATA) begin
            data[bit_count] <= in;
        end
    end
endmodule
