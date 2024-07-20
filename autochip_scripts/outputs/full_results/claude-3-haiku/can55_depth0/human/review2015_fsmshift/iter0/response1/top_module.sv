module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam [1:0] IDLE = 2'b00, SHIFT = 2'b01, HOLD = 2'b10;
reg [1:0] state, next_state;
reg [1:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counter <= 0;
        shift_ena <= 1'b1;
    end
    else begin
        state <= next_state;
        counter <= (state == SHIFT) ? counter + 1 : counter;
        shift_ena <= (state == SHIFT) ? 1'b1 : 1'b0;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            next_state = SHIFT;
        end
        SHIFT: begin
            next_state = (counter == 2'd3) ? HOLD : SHIFT;
        end
        HOLD: begin
            next_state = IDLE;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
