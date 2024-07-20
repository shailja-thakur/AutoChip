module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

parameter IDLE = 2'b00;
parameter SHIFT = 2'b01;
parameter DONE = 2'b11;

reg [1:0] state, next_state;
reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        count <= 0;
        shift_ena <= 1'b1;
    end
    else begin
        state <= next_state;
        count <= (state == SHIFT) ? count + 1 : count;
        shift_ena <= (state == SHIFT) ? 1'b1 : 1'b0;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (reset) begin
                next_state = SHIFT;
            end
            else begin
                next_state = IDLE;
            end
        end
        SHIFT: begin
            if (count == 2'b11) begin
                next_state = DONE;
            end
            else begin
                next_state = SHIFT;
            end
        end
        DONE: begin
            next_state = IDLE;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
