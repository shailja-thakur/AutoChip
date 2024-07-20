module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [2:0] state, next_state;

    // State encoding
    localparam B0 = 3'b000;
    localparam B1 = 3'b001;
    localparam B2 = 3'b010;
    localparam B3 = 3'b011;
    localparam Done = 3'b100;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B0;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            B0: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = Done;
            default: next_state = Done;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            B0: shift_ena = 1;
            B1: shift_ena = 1;
            B2: shift_ena = 1;
            B3: shift_ena = 1;
            Done: shift_ena = 0;
            default: shift_ena = 0;
        endcase
    end

endmodule
