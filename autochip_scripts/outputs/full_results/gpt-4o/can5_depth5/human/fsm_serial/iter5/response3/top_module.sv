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
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count;

    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
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
                next_state = DATA; // Move to DATA state right after START state
            end
            DATA: begin
                if (bit_count == 7)
                    next_state = STOP;
                else
                    next_state = DATA;
            end
            STOP: begin
                if (in) // 'in' detected 1 (stop bit)
                    next_state = IDLE;
                else
                    next_state = ERROR; // go to ERROR if stop bit is not detected
            end
            ERROR: begin
                if (in) // valid stop bit detected
                    next_state = IDLE;
            end
        endcase
    end

    // Bit Count Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 3'b000;
        end else if (current_state == DATA) begin
            bit_count <= bit_count + 1;
        end else if (current_state == START) begin
            bit_count <= 3'b000; // Reset bit count at the start of DATA
        end
    end

    // Done Signal Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            done <= 0;
        end else if ((current_state == STOP) && (in)) begin
            done <= 1; // indicate successful reception
        end else begin
            done <= 0;
        end
    end

endmodule
