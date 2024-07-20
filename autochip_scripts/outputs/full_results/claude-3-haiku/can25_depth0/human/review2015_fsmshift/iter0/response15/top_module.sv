module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam [1:0] 
    IDLE = 2'b00,
    SHIFT = 2'b01,
    DONE = 2'b10;

reg [1:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            next_state = SHIFT;
            shift_ena = 1'b1;
        end
        SHIFT: begin
            if (shift_ena == 1'b1) begin
                next_state = DONE;
                shift_ena = 1'b1;
            end
            else begin
                next_state = SHIFT;
                shift_ena = 1'b0;
            end
        end
        DONE: begin
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
