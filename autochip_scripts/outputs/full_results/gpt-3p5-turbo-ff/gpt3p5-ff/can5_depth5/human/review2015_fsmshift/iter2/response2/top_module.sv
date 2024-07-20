module top_module (
    input clk,
    input reset,
    output reg shift_ena
);

    reg [1:0] state;
    reg [1:0] next_state;
    reg [2:0] count; // Counter to keep track of clock cycles
    
    parameter IDLE = 2'b00;
    parameter SET_SHIFT_ENA = 2'b01;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            count <= 0;
        end else begin
            state <= next_state;
            
            if (state == SET_SHIFT_ENA) begin
                count <= count + 1;
                if (count == 3) begin
                    count <= 0;
                end
            end
        end
    end
    
    always @(state) begin
        case (state)
            IDLE: begin
                if (reset) begin
                    next_state = SET_SHIFT_ENA;
                    shift_ena = 1'b1;
                end else begin
                    next_state = IDLE;
                    shift_ena = 1'b0;
                end
            end
            SET_SHIFT_ENA: begin
                if (count < 3) begin
                    next_state = SET_SHIFT_ENA;
                    shift_ena = 1'b1;
                end else begin
                    next_state = IDLE;
                    shift_ena = 1'b0;
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
