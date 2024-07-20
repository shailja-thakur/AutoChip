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
    reg [2:0] bit_counter;
    reg [7:0] data_byte;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic, bit counter and output logic
    always @(*) begin
        next_state = state;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START;
                end
            end
            START: begin
                if (in == 1'b0) begin
                    next_state = DATA;
                    bit_counter = 3'b000;
                end else begin
                    next_state = IDLE;
                end
            end
            DATA: begin
                if (bit_counter == 3'b111) begin
                    next_state = STOP;
                end else begin
                    bit_counter = bit_counter + 1;
                end
            end
            STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                    done = 1'b1;
                end else begin
                    next_state = ERROR;
                end
            end
            ERROR: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Data byte reception
    always @(posedge clk) begin
        if (reset) begin
            data_byte <= 8'b0;
        end else if (state == DATA) begin
            data_byte[bit_counter] <= in;
        end
    end

endmodule
