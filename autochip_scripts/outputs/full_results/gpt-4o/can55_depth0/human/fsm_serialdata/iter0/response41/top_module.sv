module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);
    typedef enum reg [2:0] {
        IDLE,
        START,
        DATA,
        STOP
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data_shift_reg;

    // State Transition
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_count <= 0;
            out_byte <= 8'b0;
            done <= 0;
        end 
        else begin
            current_state <= next_state;
            if (current_state == DATA)
                bit_count <= bit_count + 1;
            if (current_state == STOP && next_state == IDLE)
                done <= 1;
            else
                done <= 0;
        end
    end

    // Next State Logic
    always @ (*) begin
        case (current_state)
            IDLE: begin
                if (!in)
                    next_state = START;
                else
                    next_state = IDLE;
            end
            START: begin
                if (in)
                    next_state = IDLE;
                else
                    next_state = DATA;
            end
            DATA: begin
                if (bit_count == 3'b111)
                    next_state = STOP;
                else
                    next_state = DATA;
            end
            STOP: begin
                if (in)
                    next_state = IDLE;
                else
                    next_state = START;
            end
            default: next_state = IDLE;
        endcase
    end

    // Data Shift Register
    always @ (posedge clk) begin
        if (current_state == IDLE) begin
            bit_count <= 0;
            data_shift_reg <= 0;
        end
        else if (current_state == DATA) begin
            data_shift_reg <= {in, data_shift_reg[7:1]};
        end
    end

    // Output Byte Logic
    always @ (posedge clk) begin
        if (current_state == STOP)
            out_byte <= data_shift_reg;
    end

endmodule
