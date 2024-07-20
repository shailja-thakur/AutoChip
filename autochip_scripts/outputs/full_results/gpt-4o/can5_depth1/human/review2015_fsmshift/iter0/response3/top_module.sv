module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [2:0] state, next_state;

    localparam S_IDLE = 3'd0, S_ENABLE_0 = 3'd1, S_ENABLE_1 = 3'd2, 
               S_ENABLE_2 = 3'd3, S_ENABLE_3 = 3'd4, S_DONE = 3'd5;

    // State transition logic (next state)
    always @(*) begin
        case (state)
            S_IDLE:     next_state = reset ? S_ENABLE_0 : S_IDLE;
            S_ENABLE_0: next_state = S_ENABLE_1;
            S_ENABLE_1: next_state = S_ENABLE_2;
            S_ENABLE_2: next_state = S_ENABLE_3;
            S_ENABLE_3: next_state = S_DONE;
            S_DONE:     next_state = S_DONE;
            default:    next_state = S_IDLE; // Safety default state
        endcase
    end

    // State flip-flops (sequential logic)
    always @(posedge clk) begin
        if (reset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            S_ENABLE_0, S_ENABLE_1, S_ENABLE_2, S_ENABLE_3:
                shift_ena = 1'b1;
            default:
                shift_ena = 1'b0;
        endcase
    end

endmodule
