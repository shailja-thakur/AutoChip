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
            done <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next State Logic
    always @(*) begin
        next_state = current_state;
        done = 0; // default value for done
        case (current_state)
            IDLE: begin
                if (~in) // 'in' detected 0 (start bit)
                    next_state = START;
                else
                    next_state = IDLE;
            end
            START: begin
                next_state = RECEIVE; // Move to RECEIVE state right after START state
            end
            RECEIVE: begin
                if (bit_count < 7)
                    next_state = RECEIVE;
                else
                    next_state = STOP;
            end
            STOP: begin
                if (in) begin // 'in' detected 1 (stop bit)
                    next_state = IDLE;
                    done = 1; // Indicate successful reception when stop bit is correct
                end else begin
                    next_state = IDLE; // reset the FSM if stop bit is not detected
                end
            end
        endcase
    end

    // Bit Count Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 3'b000;
        end else if (current_state == RECEIVE) begin
            bit_count <= bit_count + 1;
        end else if (current_state == START) begin
            bit_count <= 3'b000; // Reset bit count on START
        end
    end

endmodule
