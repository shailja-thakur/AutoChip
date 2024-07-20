module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam CYCLE_COUNT = 4;

reg [1:0] state;
parameter IDLE = 2'd0, ENABLE = 2'd1, DISABLE = 2'd2;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                shift_ena <= 1'b1;
                state <= ENABLE;
            end
            ENABLE: begin
                if (CYCLE_COUNT == 4'd4) begin
                    shift_ena <= 1'b0;
                    state <= DISABLE;
                end
                else begin
                    shift_ena <= 1'b1;
                    state <= ENABLE;
                end
            end
            DISABLE: begin
                shift_ena <= 1'b0;
                state <= DISABLE;
            end
            default: begin
                shift_ena <= 1'b0;
                state <= IDLE;
            end
        endcase
    end
end

endmodule
