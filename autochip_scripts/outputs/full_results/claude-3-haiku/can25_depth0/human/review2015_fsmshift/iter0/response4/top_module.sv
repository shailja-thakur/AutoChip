module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

parameter IDLE = 2'b00, SHIFT = 2'b01, COUNT = 2'b10;
reg [1:0] state, next_state;
reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        count <= 0;
    end
    else begin
        state <= next_state;
        count <= (state == SHIFT) ? count + 1 : count;
    end
end

always @* begin
    case (state)
        IDLE: begin
            shift_ena = 1'b1;
            next_state = SHIFT;
        end
        SHIFT: begin
            shift_ena = 1'b1;
            next_state = (count == 2'd3) ? COUNT : SHIFT;
        end
        COUNT: begin
            shift_ena = 1'b0;
            next_state = IDLE;
        end
        default: begin
            shift_ena = 1'b0;
            next_state = IDLE;
        end
    endcase
end

endmodule
