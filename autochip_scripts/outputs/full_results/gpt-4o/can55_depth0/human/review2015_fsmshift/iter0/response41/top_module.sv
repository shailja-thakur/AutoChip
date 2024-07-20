module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [2:0] state, next_state;
    localparam S_IDLE = 3'd0, S_SHIFT1 = 3'd1, S_SHIFT2 = 3'd2, S_SHIFT3 = 3'd3, S_SHIFT4 = 3'd4, S_DONE = 3'd5;

    // State register
    always @(posedge clk) begin
        if (reset)
            state <= S_IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            S_IDLE: next_state = (reset) ? S_SHIFT1 : S_IDLE;
            S_SHIFT1: next_state = S_SHIFT2;
            S_SHIFT2: next_state = S_SHIFT3;
            S_SHIFT3: next_state = S_SHIFT4;
            S_SHIFT4: next_state = S_DONE;
            S_DONE: next_state = S_DONE;
            default: next_state = S_IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            shift_ena <= 1;
        else begin
            case (state)
                S_SHIFT1, S_SHIFT2, S_SHIFT3, S_SHIFT4: shift_ena <= 1;
                S_DONE: shift_ena <= 0;
                default: shift_ena <= 0;
            endcase
        end
    end

endmodule
