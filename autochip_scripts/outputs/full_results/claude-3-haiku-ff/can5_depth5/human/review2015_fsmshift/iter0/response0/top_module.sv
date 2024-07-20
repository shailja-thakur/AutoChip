module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam IDLE = 2'b00;
localparam SHIFT_ENABLE = 2'b01;
localparam SHIFT_DISABLE = 2'b10;

reg [1:0] state;
reg [1:0] next_state;
reg [1:0] cycle_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        cycle_count <= 2'b00;
        shift_ena <= 1'b0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                shift_ena <= 1'b0;
                if (reset) begin
                    next_state <= SHIFT_ENABLE;
                    cycle_count <= 2'b00;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            SHIFT_ENABLE: begin
                shift_ena <= 1'b1;
                cycle_count <= cycle_count + 1'b1;
                if (cycle_count == 2'b11) begin
                    next_state <= SHIFT_DISABLE;
                end
                else begin
                    next_state <= SHIFT_ENABLE;
                end
            end
            SHIFT_DISABLE: begin
                shift_ena <= 1'b0;
                next_state <= IDLE;
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end

endmodule
