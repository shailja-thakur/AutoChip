module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011
    } state_t;

    state_t current_state, next_state;
    reg [3:0] bit_count;
    reg [7:0] data_byte;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 0;
            data_byte <= 8'b0;
            done <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        case (current_state)
            IDLE: begin
                if (in == 0) begin
                    next_state <= START;
                    bit_count <= 0;
                end else begin
                    next_state <= IDLE;
                end
                done <= 0;
            end

            START: begin
                if (in == 0) begin
                    next_state <= DATA;
                end else begin
                    next_state <= IDLE; // False start bit, return to idle
                end
            end

            DATA: begin
                data_byte[bit_count] <= in;
                bit_count <= bit_count + 1;
                if (bit_count == 8) begin
                    next_state <= STOP;
                end else begin
                    next_state <= DATA;
                end
            end

            STOP: begin
                if (in == 1) begin
                    done <= 1;
                    next_state <= IDLE; // Reset to IDLE for next byte
                end else begin
                    done <= 0;
                    next_state <= STOP; // Waiting for stop bit to be correct
                end
            end

            default: next_state <= IDLE;
        endcase
    end

endmodule
