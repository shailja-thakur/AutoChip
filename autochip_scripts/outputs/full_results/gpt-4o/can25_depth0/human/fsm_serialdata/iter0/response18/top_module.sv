module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // States of the FSM
    typedef enum logic [2:0] {
        IDLE    = 3'b000,
        START   = 3'b001,
        DATA    = 3'b010,
        STOP    = 3'b011,
        DONE    = 3'b100
    } state_t;

    state_t current_state, next_state;

    reg [7:0] data_reg;
    reg [2:0] bit_count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            out_byte <= 8'b0;
            done <= 0;
            data_reg <= 8'b0;
            bit_count <= 3'b0;
        end else begin
            current_state <= next_state;
            case (current_state)
                IDLE: begin
                    done <= 0;
                end
                DONE: begin
                    done <= 1;
                    out_byte <= data_reg;
                end
                default: begin
                    done <= 0;
                end
            endcase
        end
    end

    always_comb begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if (in == 0)  // Start bit detected
                    next_state = START;
            end
            START: begin
                if (in == 0)  // Ensure we are still in the start bit
                    next_state = DATA;
                else
                    next_state = IDLE;  // False start, stay in IDLE
            end
            DATA: begin
                if (bit_count == 3'd7)  // Check if we have received 8 bits
                    next_state = STOP;
                else
                    next_state = DATA;
            end
            STOP: begin
                if (in == 1)  // Stop bit detected
                    next_state = DONE;
                else
                    next_state = IDLE;  // Stop bit not detected, return to IDLE
            end
            DONE: begin
                next_state = IDLE;  // After DONE, always return to IDLE
            end
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 3'b0;
        end else if (current_state == DATA) begin
            data_reg[bit_count] <= in;
            bit_count <= bit_count + 1;
        end else if (current_state == DONE || current_state == IDLE) begin
            bit_count <= 3'b0;
        end
    end

endmodule
