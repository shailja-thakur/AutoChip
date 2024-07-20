module top_module(
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
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        S4 = 3'b100,
        SHIFT = 3'b101,
        COUNT = 3'b110,
        DONE = 3'b111
    } state_t;

    state_t state, next_state;
    reg [2:0] shift_counter; // Counter for shift_ena

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_counter <= 3'd0;
        end else begin
            state <= next_state;
            if (shift_ena) 
                shift_counter <= shift_counter + 3'd1;
            else 
                shift_counter <= 3'd0;
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
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
                if (data == 1'b1) next_state = S4;
                else next_state = IDLE;
            end
            S4: begin
                if (data == 1'b1) next_state = SHIFT;
                else next_state = IDLE;
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 3'd3) next_state = COUNT;
            end
            COUNT: begin
                counting = 1'b1;
                if (done_counting) next_state = DONE;
            end
            DONE: begin
                done = 1'b1;
                if (ack) next_state = IDLE;
            end
        endcase
    end
endmodule
