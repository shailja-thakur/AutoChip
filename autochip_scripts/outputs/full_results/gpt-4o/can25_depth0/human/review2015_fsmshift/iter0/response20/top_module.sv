module top_module(
    input clk,
    input reset,
    output reg shift_ena
);
    reg [2:0] state, next_state;

    // State encoding
    localparam S_IDLE = 3'b000,
               S_EN1  = 3'b001,
               S_EN2  = 3'b010,
               S_EN3  = 3'b011,
               S_EN4  = 3'b100,
               S_DONE = 3'b101;

    // State transition logic
    always @(posedge clk) begin
        if (reset)
            state <= S_EN1; // Start enabling shift register on reset
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            S_IDLE: next_state = S_IDLE;
            S_EN1: next_state = S_EN2;
            S_EN2: next_state = S_EN3;
            S_EN3: next_state = S_EN4;
            S_EN4: next_state = S_DONE;
            S_DONE: next_state = S_IDLE;
            default: next_state = S_IDLE;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            shift_ena <= 1;
        else if (state != S_DONE)
            shift_ena <= 1;
        else
            shift_ena <= 0;
    end

endmodule
