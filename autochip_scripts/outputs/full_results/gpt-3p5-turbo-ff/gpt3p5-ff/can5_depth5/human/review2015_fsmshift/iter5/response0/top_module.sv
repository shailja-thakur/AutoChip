module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [1:0] state;
    reg [1:0] next_state;
    
    parameter IDLE = 2'b00;
    parameter SET_SHIFT_ENA = 2'b01;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            shift_ena <= 1'b1;
        end else begin
            state <= next_state;
            shift_ena <= 1'b0;
        end
    end
    
    always @(state) begin
        case (state)
            IDLE: 
                if (reset) begin
                    next_state = SET_SHIFT_ENA;
                end else if (reset == 1 && state == IDLE) begin
                    next_state = SET_SHIFT_ENA;
                end else begin
                    next_state = IDLE;
                end
            SET_SHIFT_ENA:
                next_state = IDLE;
            default:
                next_state = IDLE;
        endcase
    end

endmodule
