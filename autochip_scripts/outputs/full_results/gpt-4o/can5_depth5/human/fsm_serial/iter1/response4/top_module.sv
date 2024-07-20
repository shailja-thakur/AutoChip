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
        end else begin
            current_state <= next_state;
        end
    end

    // Next State Logic
    always @(*) begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                done = 1'b0;
                if (~in) // Detect start bit (logic 0)
                    next_state = START;
            end
            START: begin
                if (in == 1'b0) // Confirm start bit
                    next_state = RECEIVE;
                else
                    next_state = IDLE;
            end
            RECEIVE: begin
                if (bit_count < 3'b111)
                    next_state = RECEIVE;
                else
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1'b1) // Detect stop bit (logic 1)
                    next_state = IDLE;
                else
                    next_state = ERROR;
            end
            ERROR: begin
                if (in == 1'b1) // Wait until the line is idle
                    next_state = IDLE;
            end
        endcase
    end

    // Bit Count & Data Byte Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 3'b000;
            data_byte <= 8'b00000000;
            done <= 1'b0;
        end else begin
            case (current_state)
                IDLE: begin
                    bit_count <= 3'b000;
                    data_byte <= 8'b00000000;
                    done <= 1'b0;
                end
                START: begin
                    bit_count <= 3'b000;
                    data_byte <= 8'b00000000;
                end
                RECEIVE: begin
                    data_byte <= {in, data_byte[7:1]}; // Shift-in the data bits
                    bit_count <= bit_count + 1;
                end
                STOP: begin
                    if (in == 1'b1) begin
                        done <= 1'b1; // Indicate successful reception
                        bit_count <= 3'b000;
                        data_byte <= 8'b00000000;
                    end else begin
                        done <= 1'b0;
                    end
                end
                ERROR: begin
                    done <= 1'b0;
                end
            endcase
        end
    end

endmodule
