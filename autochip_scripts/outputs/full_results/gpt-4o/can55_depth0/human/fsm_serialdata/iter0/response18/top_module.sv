module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE    = 3'b000,
        START   = 3'b001,
        DATA    = 3'b010,
        STOP    = 3'b011,
        WAIT    = 3'b100
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_count;
    reg [7:0] data_byte;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next state logic
    always @(*) begin
        next_state = current_state; // Default to hold state
        done = 0;                   // Default to done = 0
        case (current_state)
            IDLE: begin
                if (in == 0)
                    next_state = START;
            end
            START: begin
                next_state = DATA;
            end
            DATA: begin
                if (bit_count == 3'b111)
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1) begin
                    next_state = IDLE;
                    done = 1;
                end else
                    next_state = WAIT;
            end
            WAIT: begin
                if (in == 1)
                    next_state = IDLE;
            end
        endcase
    end

    // Bit counter and data byte shifting
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            bit_count <= 3'b000;
            data_byte <= 8'b0;
            out_byte <= 8'b0;
        end else begin
            case (current_state)
                START: begin
                    bit_count <= 3'b000;
                end
                DATA: begin
                    data_byte[bit_count] <= in;
                    bit_count <= bit_count + 1;
                end
                STOP: begin
                    if (in == 1)
                        out_byte <= data_byte;
                end
            endcase
        end
    end

endmodule
