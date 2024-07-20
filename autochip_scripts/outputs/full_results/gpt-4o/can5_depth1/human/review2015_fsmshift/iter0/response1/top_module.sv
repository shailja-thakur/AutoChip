module top_module(
	input clk,
	input reset,
	output reg shift_ena);

    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        SHIFT = 2'b01,
        DONE = 2'b10
    } state_t;
	
    reg [1:0] state, next_state;
    reg [2:0] count; // 3-bit counter to count 4 clock cycles
	
    // State transition logic
    always @ (posedge clk) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // State machine next state logic
    always @ (*) begin
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
                if (count == 3'b100)
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

    // Counter for the SHIFT state
    always @ (posedge clk) begin
        if (reset)
            count <= 3'b000;
        else if (state == SHIFT)
            count <= count + 1;
        else
            count <= 3'b000;
    end
	
endmodule
