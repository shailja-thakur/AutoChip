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
                next_state = RECEIVE;
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
                    done = 1; // indicate successful reception
                end else
                    next_state = IDLE; // reset the FSM if stop bit is not detected
            end
        endcase
    end

    // Bit Count & Data Byte Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 3'b000;
            data_byte <= 8'b00000000;
        end else if (current_state == RECEIVE) begin
            data_byte <= {in, data_byte[7:1]}; // shift-in the data bits
            bit_count <= bit_count + 1;
        end else begin
            bit_count <= 3'b000;
            data_byte <= 8'b00000000;
        end
    end

endmodule
