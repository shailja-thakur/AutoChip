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
    typedef enum logic [2:0] {
        IDLE        = 3'b000,
        MATCH_1     = 3'b001,
        MATCH_11    = 3'b010,
        MATCH_110   = 3'b011,
        MATCH_1101  = 3'b100,
        SHIFT       = 3'b101,
        COUNTING    = 3'b110,
        DONE        = 3'b111
    } state_t;

    state_t state, next_state;
    reg [1:0] shift_counter;

    // State transition logic (sequential)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            shift_counter <= 2'b00;
        end else begin
            state <= next_state;
            if (state == SHIFT)
                shift_counter <= shift_counter + 1;
            else
                shift_counter <= 2'b00;
        end
    end

    // Next state logic (combinational)
    always @(*) begin
        next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;
        
        case (state)
            IDLE: begin
                if (data) next_state = MATCH_1;
            end
            
            MATCH_1: begin
                if (!data) next_state = MATCH_11;
                else if (!data) next_state = IDLE;
            end

            MATCH_11: begin
                if (data) next_state = MATCH_110;
                else next_state = IDLE;
            end

            MATCH_110: begin
                if (!data) next_state = MATCH_1101;
                else if (!data) next_state = IDLE;
            end
            
            MATCH_1101: begin
                if (data) next_state = SHIFT;
                else next_state = IDLE;
            end

            SHIFT: begin
                shift_ena = 1'b1;
                if (shift_counter == 2'b11) next_state = COUNTING;
            end

            COUNTING: begin
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
