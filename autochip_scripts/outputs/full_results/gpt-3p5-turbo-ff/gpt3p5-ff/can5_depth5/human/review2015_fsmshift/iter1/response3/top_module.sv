module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [1:0] state;
    reg [1:0] next_state;
    reg [3:0] counter;
    
    parameter IDLE = 2'b00;
    parameter SET_SHIFT_ENA = 2'b01;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0000;
        end else begin
            state <= next_state;
            counter <= counter + 1'b1;
        end
    end
    
    always @(state, counter) begin
        case (state)
            IDLE: begin
                if (reset) begin
                    if (counter < 4) begin
                        next_state = SET_SHIFT_ENA;
                        shift_ena = 1'b1;
                    end else begin
                        next_state = IDLE;
                        shift_ena = 1'b0;
                    end
                end else begin
                    next_state = IDLE;
                    shift_ena = 1'b0;
                end
            end
            SET_SHIFT_ENA: begin
                next_state = IDLE;
                shift_ena = 1'b0;
            end
            default: begin
                next_state = IDLE;
                shift_ena = 1'b0;
            end
        endcase
    end
endmodule
