module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam ENABLE_CYCLES = 4;

reg [1:0] state;
parameter IDLE = 2'd0, ENABLE = 2'd1;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                shift_ena <= 1'b0;
                if (reset) begin
                    state <= IDLE;
                    shift_ena <= 1'b1;
                end
                else begin
                    state <= ENABLE;
                    shift_ena <= 1'b1;
                end
            end
            ENABLE: begin
                shift_ena <= 1'b1;
                if (ENABLE_CYCLES == 1) begin
                    state <= IDLE;
                    shift_ena <= 1'b0;
                end
                else begin
                    ENABLE_CYCLES <= ENABLE_CYCLES - 1;
                end
            end
        endcase
    end
end

endmodule
