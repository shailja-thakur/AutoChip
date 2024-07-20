module top_module (
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        SHIFT = 3'b100,
        COUNT = 3'b101,
        DONE = 3'b110
    } state_t;

    reg [2:0] state, next_state;
    reg [1:0] shift_count;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state; // Default to maintain current state
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            IDLE: begin
                if (data == 1'b1) next_state = S1;
            end
            S1: begin
                if (data == 1'b1) next_state = S2;
                else next_state = IDLE;
            end
            S2: begin
                if (data == 1'b0) next_state = S3;
                else next_state = IDLE;
            end
            S3: begin
                if (data == 1'b1) next_state = SHIFT;
                else next_state = IDLE;
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_count == 2'b11) 
                    next_state = COUNT;
            end
            COUNT: begin
                counting = 1'b1;
                if (done_counting) 
                    next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (ack) 
                    next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Shift count control
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_count <= 2'b00;
        end else if (shift_ena) begin
            shift_count <= shift_count + 1'b1;
        end else begin
            shift_count <= 2'b00;
        end
    end

endmodule
