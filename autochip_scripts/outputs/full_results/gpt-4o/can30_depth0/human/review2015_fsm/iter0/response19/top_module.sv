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
    typedef enum logic [3:0] {
        S_IDLE = 4'b0000,
        S_1 = 4'b0001,
        S_11 = 4'b0010,
        S_110 = 4'b0011,
        S_1101 = 4'b0100,
        S_SHIFT = 4'b0101,
        S_COUNTING = 4'b0110,
        S_DONE = 4'b0111
    } state_t;
    
    state_t  state, next_state;
    reg [2:0] shift_counter; // Counter for 4 shifts

    // State transition logic
    always @(*) begin
        next_state = state;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            S_IDLE: if (data == 1'b1) next_state = S_1;
            S_1:    if (data == 1'b1) next_state = S_11; else next_state = S_IDLE;
            S_11:   if (data == 1'b0) next_state = S_110; else next_state = S_IDLE;
            S_110:  if (data == 1'b1) next_state = S_1101; else next_state = S_IDLE;
            S_1101: begin
                        shift_ena = 1'b1;
                        if (shift_counter == 3'd3) next_state = S_SHIFT;
                    end
            S_SHIFT: begin
                        shift_ena = 1'b1;
                        if (shift_counter == 3'd3) next_state = S_COUNTING;
                     end
            S_COUNTING: begin
                            counting = 1'b1;
                            if (done_counting) next_state = S_DONE;
                        end
            S_DONE: begin
                        done = 1'b1;
                        if (ack) next_state = S_IDLE;
                    end
            default: next_state = S_IDLE;
        endcase
    end

    // State update and shift counter logic
    always @(posedge clk) begin
        if (reset) begin
            state <= S_IDLE;
            shift_counter <= 3'd0;
        end else begin
            state <= next_state;
            if (shift_ena)
                shift_counter <= shift_counter + 3'd1;
            else
                shift_counter <= 3'd0;
        end
    end
endmodule
