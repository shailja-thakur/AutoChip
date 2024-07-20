module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // Define states
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        RECEIVE = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data_reg;

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
                    done = 1; // Indicate successful reception
                    next_state = IDLE;
                end else
                    next_state = ERROR; // If stop bit is not detected, move to ERROR
            end
            ERROR: begin
                if (in) // Wait until the idle state is detected
                    next_state = IDLE;
            end
        endcase
    end

    // Bit Count and Data Register Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 3'b000;
            data_reg <= 8'b00000000;
        end else if (current_state == START) begin
            bit_count <= 3'b000; // Reset bit count at the start of RECEIVING
        end else if (current_state == RECEIVE) begin
            bit_count <= bit_count + 1;
            data_reg[bit_count] <= in; // Store each bit received
        end
    end

    // Done Signal Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 0;
        end else if (current_state == STOP && in) begin
            done <= 1; // Indicate successful reception
        end else begin
            done <= 0;
        end
    end

endmodule
