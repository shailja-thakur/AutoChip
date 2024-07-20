module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        ERROR = 3'b100
    } state_t;

    state_t state, next_state;
    reg [2:0] bit_count;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            bit_count <= 3'b000;
        end else begin
            state <= next_state;
            if (state == DATA) begin
                bit_count <= bit_count + 1;
            end else begin
                bit_count <= 3'b000;
            end
        end
    end

    // Next state logic and output logic
    always @(*) begin
        done = 0;
        next_state = state;
        case (state)
            IDLE: begin
                if (in == 0) begin
                    next_state = START;
                end
            end
            START: begin
                if (in == 0) begin
                    next_state = DATA;
                end else begin
                    next_state = IDLE;
                end
            end
            DATA: begin
                if (bit_count == 3'b111) begin
                    next_state = STOP;
                end
            end
            STOP: begin
                if (in == 1) begin
                    done = 1;
                    next_state = IDLE;
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule
