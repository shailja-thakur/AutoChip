module top_module(
	input clk,
	input reset,
	input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        PATTERN_1101 = 3'b001,
        SHIFTING = 3'b010,
        COUNTING = 3'b011,
        DONE = 3'b100
    } state_t;

    state_t state, next_state;

    // Pattern recognition
    reg [3:0] shift_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_reg <= 4'b0000;
        end else begin
            state <= next_state;
            if (state == IDLE || state == PATTERN_1101) begin
                shift_reg <= {shift_reg[2:0], data};
            end
        end
    end

    always @(*) begin
        // Default outputs
        shift_ena = 0;
        counting = 0;
        done = 0;
        next_state = state;

        case (state)
            IDLE: begin
                if (shift_reg == 4'b1101)
                    next_state = PATTERN_1101;
            end
            PATTERN_1101: begin
                shift_ena = 1;
                next_state = SHIFTING;
            end
            SHIFTING: begin
                if (shift_reg == 4'b0000)
                    next_state = COUNTING;
            end
            COUNTING: begin
                counting = 1;
                if (done_counting)
                    next_state = DONE;
            end
            DONE: begin
                done = 1;
                if (ack)
                    next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Counter to ensure shift_ena is asserted for exactly 4 clock cycles
    reg [1:0] shift_count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_count <= 2'b00;
        end else if (shift_ena) begin
            if (shift_count < 2'b11)
                shift_count <= shift_count + 1;
            else
                shift_count <= 2'b00;
        end else begin
            shift_count <= 2'b00;
        end
    end

    always @(posedge clk) begin
        if (state == PATTERN_1101 || state == SHIFTING) begin
            if (shift_ena && shift_count == 2'b11) begin
                next_state = COUNTING;
            end
        end
    end
    
endmodule
