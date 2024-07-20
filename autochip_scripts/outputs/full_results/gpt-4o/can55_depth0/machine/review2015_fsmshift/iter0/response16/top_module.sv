module top_module(
    input clk,
    input reset,
    output reg shift_ena
);
    // Define state parameters
    parameter B0 = 3'b000, B1 = 3'b001, B2 = 3'b010, B3 = 3'b011, DONE = 3'b100;

    reg [2:0] state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            B0: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = DONE;
            default: next_state = DONE;
        endcase
    end

    // Sequential block for state updates
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B0;
        else
            state <= next_state;
    end

    // Shift enable logic
    always @(*) begin
        if (state == B0 || state == B1 || state == B2 || state == B3)
            shift_ena = 1;
        else
            shift_ena = 0;
    end
endmodule
