module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    // State encodings
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        SHIFT = 2'b01,
        DONE = 2'b10
    } state_t;
    
    state_t state, next_state;
    reg [2:0] count;
    
    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= SHIFT;
            count <= 3'b000;
        end else begin
            state <= next_state;
            if (state == SHIFT)
                count <= count + 1;
        end
    end

    // Next state logic
    always @* begin
        case (state)
            IDLE: begin
                shift_ena = 1'b0;
                if (reset)
                    next_state = SHIFT;
                else
                    next_state = IDLE;
            end
            SHIFT: begin
                shift_ena = 1'b1;
                if (count == 3'b011)
                    next_state = DONE;
                else
                    next_state = SHIFT;
            end
            DONE: begin
                shift_ena = 1'b0;
                next_state = DONE;
            end
            default: begin
                shift_ena = 1'b0;
                next_state = IDLE;
            end
        endcase
    end

endmodule
