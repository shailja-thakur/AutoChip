module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    // Define state encoding
    parameter IDLE  = 3'b000,
              S1    = 3'b001,
              S11   = 3'b010,
              S110  = 3'b011,
              S1101 = 3'b100;

    reg [2:0] state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE:   next_state = data ? S1 : IDLE;
            S1:     next_state = data ? S11 : IDLE;
            S11:    next_state = data ? S11 : S110;
            S110:   next_state = data ? S1101 : IDLE;
            S1101:  next_state = data ? S1 : IDLE; // Allow for new sequences to be detected
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            start_shifting <= 1'b0;
        else if (state == S1101)
            start_shifting <= 1'b1;
    end

endmodule
