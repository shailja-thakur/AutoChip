module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [1:0] state, next_state;
    reg [2:0] count;

    // State encoding
    parameter IDLE = 2'b00;
    parameter SHIFT = 2'b01;

    // State transition
    always @(*) begin
        case (state)
            IDLE: begin
                if (reset)
                    next_state = SHIFT;
                else
                    next_state = IDLE;
            end
            SHIFT: begin
                if (count == 3'b100)
                    next_state = IDLE;
                else
                    next_state = SHIFT;
            end
            default: next_state = IDLE;
        endcase
    end

    // State register
    always @(posedge clk) begin
        if (reset)
            state <= SHIFT;
        else
            state <= next_state;
    end

    // Output logic and counter
    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1;
            count <= 0;
        end else if (state == SHIFT && count < 3'b100) begin
            shift_ena <= 1;
            count <= count + 1;
        end else begin
            shift_ena <= 0;
        end
    end
endmodule
