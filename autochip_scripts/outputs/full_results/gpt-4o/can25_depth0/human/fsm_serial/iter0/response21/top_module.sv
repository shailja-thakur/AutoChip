module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'd0,
        START = 3'd1,
        DATA = 3'd2,
        STOP = 3'd3,
        ERROR = 3'd4
    } state_t;

    state_t current_state, next_state;
    reg [3:0] bit_counter; // Counter to count bits (0-8)

    // Sequential Logic: State Transitions
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 4'd0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational Logic: Next State and Output Logic
    always_comb begin
        next_state = current_state; // Default to current state
        done = 1'b0;                // Default to not done

        case (current_state)
            IDLE: begin
                if (in == 1'b0) // Start bit detected
                    next_state = START;
            end

            START: begin
                next_state = DATA;
            end

            DATA: begin
                if (bit_counter == 4'd8) begin
                    if (in == 1'b1) // Stop bit detected
                        next_state = STOP;
                    else
                        next_state = ERROR;
                end
            end

            STOP: begin
                done = 1'b1;   // Byte received correctly
                next_state = IDLE;
                bit_counter = 4'd0;
            end

            ERROR: begin
                if (in == 1'b1) // Wait for stop bit
                    next_state = IDLE;
            end

            default: begin
                next_state = IDLE; // Default to IDLE for safety
                bit_counter = 4'd0;
            end
        endcase
    end

    // Bit Counter Logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_counter <= 4'd0;
        end else if (current_state == DATA) begin
            bit_counter <= bit_counter + 4'd1;
        end else begin
            bit_counter <= 4'd0;
        end
    end

endmodule
