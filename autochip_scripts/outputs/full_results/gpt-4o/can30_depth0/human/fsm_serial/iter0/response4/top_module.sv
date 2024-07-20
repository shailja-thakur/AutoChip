module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State declarations
    typedef enum reg [2:0] {
        IDLE     = 3'b000,
        START    = 3'b001,
        DATA     = 3'b010,
        STOP     = 3'b011,
        ERROR    = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_counter <= 0;
            done <= 0;
        end else begin
            state <= next_state;
            if (state == DATA) begin
                bit_counter <= bit_counter + 1;
            end else begin
                bit_counter <= 0;
            end
        end
    end

    always @(*) begin
        case (state)
            IDLE: begin
                done = 0;
                if (in == 0)  // Start bit detected
                    next_state = START;
                else
                    next_state = IDLE;
            end

            START: begin
                done = 0;
                next_state = DATA;
            end

            DATA: begin
                done = 0;
                if (bit_counter == 3'd7)
                    next_state = STOP;
                else
                    next_state = DATA;
            end

            STOP: begin
                if (in == 1) begin  // Valid stop bit
                    done = 1;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end

            ERROR: begin
                done = 0;
                if (in == 1)  // Wait until line is idle
                    next_state = IDLE;
                else
                    next_state = ERROR;
            end

            default: begin
                next_state = IDLE;
                done = 0;
            end
        endcase
    end

endmodule
