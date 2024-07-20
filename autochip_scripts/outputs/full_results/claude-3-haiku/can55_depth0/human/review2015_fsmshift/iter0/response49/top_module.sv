module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam IDLE = 2'b00,
          ENABLE = 2'b01,
          COUNT = 2'b10;

reg [1:0] state, next_state;

always @(posedge clk) begin
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
            if (reset) begin
                next_state = ENABLE;
            end
            else begin
                next_state = IDLE;
            end
            shift_ena = 1'b0;
        end
        ENABLE: begin
            next_state = COUNT;
            shift_ena = 1'b1;
        end
        COUNT: begin
            if (reset) begin
                next_state = ENABLE;
            end
            else if (shift_ena == 1'b1) begin
                next_state = COUNT;
                shift_ena = 1'b1;
            end
            else begin
                next_state = IDLE;
                shift_ena = 1'b0;
            end
        end
        default: begin
            next_state = IDLE;
            shift_ena = 1'b0;
        end
    endcase
end

endmodule
