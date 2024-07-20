module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] count;
    reg [1:0] state, next_state;

    // States
    localparam IDLE = 2'b00;
    localparam SHIFT = 2'b01;
    localparam HOLD = 2'b10;

    // State Transition
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 0;
        end
        else begin
            state <= next_state;
            if (state == SHIFT) 
                count <= count + 1;
            else
                count <= 0;
        end
    end

    // Next State Logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (reset)
                    next_state = SHIFT;
                else
                    next_state = IDLE;
            end
            SHIFT: begin
                if (count == 3)
                    next_state = HOLD;
                else
                    next_state = SHIFT;
            end
            HOLD: begin
                next_state = HOLD;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output Logic
    always @(*) begin
        if (state == SHIFT)
            shift_ena = 1;
        else
            shift_ena = 0;
    end

endmodule
