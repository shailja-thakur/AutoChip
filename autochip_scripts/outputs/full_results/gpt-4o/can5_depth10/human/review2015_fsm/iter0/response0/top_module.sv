module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    typedef enum reg [2:0] {
        IDLE = 3'b000,
        S1   = 3'b001,
        S2   = 3'b010,
        S3   = 3'b011,
        S4   = 3'b100,
        SHIFT = 3'b101,
        COUNT = 3'b110,
        DONE = 3'b111
    } state_t;

    state_t state, next_state;
    reg [1:0] shift_count;
    
    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        shift_ena = 0;
        counting = 0;
        done = 0;
        next_state = state;

        case (state)
            IDLE: begin
                if (data == 1) next_state = S1;
            end
            S1: begin
                if (data == 1) next_state = S2;
                else next_state = IDLE;
            end
            S2: begin
                if (data == 0) next_state = S3;
                else next_state = IDLE;
            end
            S3: begin
                if (data == 1) next_state = S4;
                else next_state = IDLE;
            end
            S4: begin
                if (data == 1) next_state = SHIFT;
                else next_state = IDLE;
            end
            SHIFT: begin
                if (shift_count == 4) next_state = COUNT;
                else next_state = SHIFT;
                shift_ena = 1;
            end
            COUNT: begin
                counting = 1;
                if (done_counting) next_state = DONE;
            end
            DONE: begin
                done = 1;
                if (ack) next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Shift counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_count <= 0;
        end else if (state == SHIFT) begin
            if (shift_count < 4)
                shift_count <= shift_count + 1;
            else
                shift_count <= 0;
        end else begin
            shift_count <= 0;
        end
    end

endmodule
