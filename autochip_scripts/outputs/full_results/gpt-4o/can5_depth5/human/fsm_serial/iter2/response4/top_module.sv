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
    reg [7:0] data_byte;

    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 3'b000;
            data_byte <= 8'b00000000;
            done <= 0;
        end else begin
            current_state <= next_state;
            if (current_state == RECEIVE) begin
                data_byte <= {in, data_byte[7:1]}; // shift-in the data bits
                bit_count <= bit_count + 1;
            end else if (current_state == STOP && in) begin
                done <= 1; // indicate successful reception
            end else begin
                done <= 0;
            end
        end
    end

    // Next State Logic
    always @(*) begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (~in) // in detected 0 (start bit)
                    next_state = START;
            end
            START: begin
                next_state = RECEIVE;
            end
            RECEIVE: begin
                if (bit_count == 3'd7)
                    next_state = STOP;
                else
                    next_state = RECEIVE;
            end
            STOP: begin
                if (in) // in detected 1 (stop bit)
                    next_state = IDLE;
                else
                    next_state = ERROR;
            end
            ERROR: begin
                if (in) // wait until stop bit is detected
                    next_state = IDLE;
            end
        endcase
    end

    // Clear bit counter and data byte in IDLE state
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 3'b000;
            data_byte <= 8'b00000000;
        end else if (current_state == START || current_state == IDLE || current_state == ERROR) begin
            bit_count <= 3'b000;
            data_byte <= 8'b00000000;
        end
    end

endmodule
