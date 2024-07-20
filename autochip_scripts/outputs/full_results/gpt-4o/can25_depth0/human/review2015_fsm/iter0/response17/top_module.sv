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
        IDLE        = 3'b000,
        DETECT_1    = 3'b001,
        DETECT_11   = 3'b010,
        DETECT_110  = 3'b011,
        DETECT_1101 = 3'b100,
        SHIFTING    = 3'b101,
        COUNTING    = 3'b110,
        DONE        = 3'b111
    } state_t;

    state_t state, next_state;
    reg [2:0] shift_counter;

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_counter <= 3'b000;
        end else begin
            state <= next_state;
            if (state == SHIFTING) begin
                if (shift_counter < 3'b100) begin
                    shift_counter <= shift_counter + 3'b001;
                end else begin
                    shift_counter <= 3'b000;
                end
            end else begin
                shift_counter <= 3'b000;
            end
        end
    end

    // Combinational logic for next state and outputs
    always @(*) begin
        // Default values for outputs
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (data) begin
                    next_state = DETECT_1;
                end else begin
                    next_state = IDLE;
                end
            end

            DETECT_1: begin
                if (data) begin
                    next_state = DETECT_11;
                end else begin
                    next_state = IDLE;
                end
            end

            DETECT_11: begin
                if (!data) begin
                    next_state = DETECT_110;
                end else begin
                    next_state = IDLE;
                end
            end

            DETECT_110: begin
                if (data) begin
                    next_state = DETECT_1101;
                end else begin
                    next_state = IDLE;
                end
            end

            DETECT_1101: begin
                shift_ena = 1'b1;
                if (shift_counter == 3'b011) begin
                    next_state = SHIFTING;
                end else begin
                    next_state = DETECT_1101;
                end
            end
            
            SHIFTING: begin
                shift_ena = 1'b1;
                if (shift_counter == 3'b100) begin
                    next_state = COUNTING;
                end else begin
                    next_state = SHIFTING;
                end
            end

            COUNTING: begin
                counting = 1'b1;
                if (done_counting) begin
                    next_state = DONE;
                end else begin
                    next_state = COUNTING;
                end
            end

            DONE: begin
                done = 1'b1;
                if (ack) begin
                    next_state = IDLE;
                end else begin
                    next_state = DONE;
                end
            end

            default: next_state = IDLE;
        endcase
    end
endmodule
