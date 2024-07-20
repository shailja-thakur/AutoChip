module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam IDLE = 2'b00;
localparam SHIFT = 2'b01;
localparam DONE = 2'b10;

reg [1:0] state, next_state;
reg [1:0] counter;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counter <= 4'd0;
        shift_ena <= 1'b0;
    end
    else begin
        state <= next_state;
        counter <= (state == SHIFT) ? counter - 1 : counter;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        IDLE: begin
            shift_ena = 1'b1;
            if (counter == 4'd3)
                next_state = DONE;
            else
                next_state = SHIFT;
        end
        SHIFT: begin
            shift_ena = 1'b1;
            if (counter == 4'd0)
                next_state = DONE;
        end
        DONE: begin
            shift_ena = 1'b0;
            if (reset)
                next_state = IDLE;
        end
        default: begin
            shift_ena = 1'b0;
            next_state = IDLE;
        end
    endcase
end

endmodule
