module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // Define states
    typedef enum reg [2:0] {
        IDLE        = 3'b000,
        START       = 3'b001,
        RECEIVE     = 3'b010,
        STOP        = 3'b011,
        ERROR       = 3'b100
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
        case (current_state)
            IDLE: begin
                done = 0;
                if (~in) begin // Detected 0 (start bit)
                    next_state = START;
                end
            end
            START: begin
                if (~in) begin
                    next_state = RECEIVE;
                end else begin
                    next_state = IDLE;
                end
            end
            RECEIVE: begin
                if (bit_count < 7) begin
                    next_state = RECEIVE;
                end else begin
                    next_state = STOP;
                end
            end
            STOP: begin
                if (in) begin // Detected 1 (stop bit)
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

    // Bit Count & Data Byte Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 3'b000;
            data_byte <= 8'b00000000;
            done <= 0;
        end else begin
            case (current_state)
                RECEIVE: begin
                    data_byte <= {in, data_byte[7:1]}; // Shift-in the data bits LSB first
                    bit_count <= bit_count + 1;
                end
                STOP: begin
                    if (in) begin
                        done <= 1; // Indicate successful reception
                    end
                end
                default: begin
                    bit_count <= 3'b000;
                    data_byte <= 8'b00000000;
                    done <= 0;
                end
            endcase
        end
    end

endmodule
