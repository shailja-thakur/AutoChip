module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam SHIFT_CYCLES = 4;

reg [1:0] state;
parameter IDLE = 2'd0, SHIFT = 2'd1;

always @(posedge clk) begin
    if (reset) begin
        state <= SHIFT;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            SHIFT: begin
                if (shift_ena == 1'b1 && SHIFT_CYCLES == 4'd4) begin
                    shift_ena <= 1'b0;
                    state <= IDLE;
                end
                else begin
                    shift_ena <= 1'b1;
                end
            end
            IDLE: begin
                shift_ena <= 1'b0;
            end
            default: begin
                state <= IDLE;
                shift_ena <= 1'b0;
            end
        endcase
    end
end

endmodule
