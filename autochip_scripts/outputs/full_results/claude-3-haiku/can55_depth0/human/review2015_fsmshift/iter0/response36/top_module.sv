module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam [1:0] IDLE = 2'b00, SHIFT = 2'b01, DONE = 2'b11;
reg [1:0] state, next_state;
reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        count <= 0;
    end
    else begin
        state <= next_state;
        count <= (state == SHIFT) ? count + 1 : 0;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        IDLE: begin
            shift_ena = 0;
            if (reset) begin
                next_state = SHIFT;
            end
        end
        SHIFT: begin
            shift_ena = 1;
            if (count == 2'd3) begin
                next_state = DONE;
            end
        end
        DONE: begin
            shift_ena = 0;
            if (reset) begin
                next_state = SHIFT;
            end
        end
    endcase
end

endmodule
