module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam RESET_COUNT = 4;

reg [1:0] state;
localparam RESET = 2'd0, SHIFT_ENABLE = 2'd1;

always @(posedge clk) begin
    if (reset) begin
        state <= RESET;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            RESET: begin
                if (shift_ena == 1'b1 && RESET_COUNT == 4) begin
                    state <= SHIFT_ENABLE;
                    shift_ena <= 1'b0;
                end
                else begin
                    shift_ena <= 1'b1;
                end
            end
            SHIFT_ENABLE: begin
                shift_ena <= 1'b0;
            end
        endcase
    end
end

endmodule
