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
    reg [3:0] bit_count; // Increased bit count size to 4 bits to handle counting logic correctly.
    reg [7:0] data_byte;

    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 4'b0000; // Initialize to 4 bits
            data_byte <= 8'b00000000;
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
                if (bit_count < 8)
                    next_state = RECEIVE;
                else
                    next_state = STOP;
            end
            STOP: begin
                if (in) // 'in' detected 1 (stop bit)
                    next_state = IDLE;
                else
                    next_state = IDLE; // reset the FSM if stop bit is not detected
            end
        endcase
    end

    // Bit Count & Data Byte Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 4'b0000;
            data_byte <= 8'b00000000;
            done <= 0;
        end else if (current_state == START) begin
            bit_count <= 4'b0000;
        end else if (current_state == RECEIVE) begin
            if (bit_count < 8) begin
                data_byte <= {in, data_byte[7:1]}; // shift-in the data bits (least significant bit first)
                bit_count <= bit_count + 1;
            end
        end else if (current_state == STOP) begin
            if (in) begin
                done <= 1; // indicate successful reception
            end else begin
                done <= 0;
            end
            bit_count <= 4'b0000;
            data_byte <= 8'b00000000;
        end else begin
            bit_count <= 4'b0000;
            data_byte <= 8'b00000000;
            done <= 0;
        end
    end

endmodule
