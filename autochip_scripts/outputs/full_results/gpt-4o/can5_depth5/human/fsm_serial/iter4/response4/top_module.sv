module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // Define states
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        START = 2'b01,
        RECEIVE = 2'b10,
        STOP = 2'b11
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count;

    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'b000;
        end else begin
            current_state <= next_state;
        end
    end

    // Bit count logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 3'b000;
        end else if (current_state == RECEIVE) begin
            if (bit_count < 3'b111) // Count until 7 (8 data bits)
                bit_count <= bit_count + 1;
            else
                bit_count <= 3'b000; // Reset bit count on transition to STOP state
        end else begin
            bit_count <= 3'b000;
        end
    end

    // FSM
    always @(*) begin
        next_state = current_state;
        done = 0; // default value for done
        case (current_state)
            IDLE: begin
                if (~in) // 'in' detected 0 (start bit)
                    next_state = START;
            end
            START: begin
                next_state = RECEIVE; // Move to RECEIVE state right after START state
            end
            RECEIVE: begin
                if (bit_count < 3'b111)
                    next_state = RECEIVE;
                else
                    next_state = STOP; // Move to STOP after 8 data bits are received
            end
            STOP: begin
                if (in) begin // 'in' detected 1 (stop bit)
                    next_state = IDLE;
                    done = 1; // Indicate successful reception
                end else begin
                    next_state = IDLE; // If stop bit is not detected, go back to IDLE
                end
            end
        endcase
    end

    // Done Signal Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 0;
        end else if (current_state == STOP && in) begin
            done <= 1; // indicate successful reception
        end else begin
            done <= 0;
        end
    end

endmodule
