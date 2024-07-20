module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        SHIFT1 = 2'b01,
        SHIFT2 = 2'b10,
        SHIFT3 = 2'b11,
        SHIFT4 = 2'b100
    } state_t;

    state_t state, next_state;
    
    // State transition logic
    always @ (posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state and output logic
    always @ (*) begin
        shift_ena = 1'b0;
        case (state)
            IDLE: begin
                if (reset) begin
                    next_state = SHIFT1;
                    shift_ena = 1'b1;
                end else
                    next_state = IDLE;
            end
            SHIFT1: begin
                next_state = SHIFT2;
                shift_ena = 1'b1;
            end
            SHIFT2: begin
                next_state = SHIFT3;
                shift_ena = 1'b1;
            end
            SHIFT3: begin
                next_state = SHIFT4;
                shift_ena = 1'b1;
            end
            SHIFT4: begin
                next_state = IDLE;
                shift_ena = 1'b0; // Shift enable stays 0 after 4 cycles
            end
            default: next_state = IDLE;
        endcase
    end
endmodule
