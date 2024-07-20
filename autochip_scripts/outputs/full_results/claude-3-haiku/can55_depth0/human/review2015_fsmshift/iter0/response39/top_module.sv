module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam CYCLE_COUNT = 4;

reg [1:0] state;
localparam [1:0] IDLE = 2'b00, ENABLE = 2'b01, DISABLE = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= ENABLE;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            ENABLE: begin
                if (shift_ena == 1'b1 && CYCLE_COUNT == 4) begin
                    state <= DISABLE;
                    shift_ena <= 1'b0;
                end
                else begin
                    shift_ena <= 1'b1;
                end
            end
            DISABLE: begin
                shift_ena <= 1'b0;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
