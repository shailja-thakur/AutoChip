module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] state, next_state;

    // State encoding
    localparam RESET   = 3'b000,
               SHIFT1  = 3'b001,
               SHIFT2  = 3'b010,
               SHIFT3  = 3'b011,
               SHIFT4  = 3'b100,
               HOLD    = 3'b101;

    // State transition
    always @ (posedge clk) begin
        if (reset) 
            state <= RESET;
        else 
            state <= next_state;
    end

    // Next state logic
    always @ (*) begin
        case (state)
            RESET:   next_state = SHIFT1;
            SHIFT1:  next_state = SHIFT2;
            SHIFT2:  next_state = SHIFT3;
            SHIFT3:  next_state = SHIFT4;
            SHIFT4:  next_state = HOLD;
            HOLD:    next_state = HOLD;
            default: next_state = RESET;
        endcase
    end

    // Output logic
    always @ (*) begin
        case (state)
            SHIFT1, SHIFT2, SHIFT3, SHIFT4: shift_ena = 1;
            default: shift_ena = 0;
        endcase
    end

endmodule
