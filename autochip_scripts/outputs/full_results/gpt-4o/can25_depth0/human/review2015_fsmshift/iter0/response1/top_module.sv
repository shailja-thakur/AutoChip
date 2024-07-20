module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] state, next_state;
    
    // State encoding
    localparam IDLE = 3'b000,
               SHIFT_0 = 3'b001,
               SHIFT_1 = 3'b010,
               SHIFT_2 = 3'b011,
               SHIFT_3 = 3'b100;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= SHIFT_0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case(state)
            IDLE: begin
                if (reset)
                    next_state = SHIFT_0;
                else
                    next_state = IDLE;
            end
            
            SHIFT_0: next_state = SHIFT_1;
            SHIFT_1: next_state = SHIFT_2;
            SHIFT_2: next_state = SHIFT_3;
            SHIFT_3: next_state = IDLE;

            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @(*) begin
        case(state)
            SHIFT_0: shift_ena = 1;
            SHIFT_1: shift_ena = 1;
            SHIFT_2: shift_ena = 1;
            SHIFT_3: shift_ena = 1;
            default: shift_ena = 0;
        endcase
    end

endmodule
