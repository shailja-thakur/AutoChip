module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam STATE_RESET = 0, STATE_ENABLE = 1;
reg [1:0] state;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_RESET;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            STATE_RESET: begin
                shift_ena <= 1'b1;
                if (shift_ena) begin
                    state <= STATE_ENABLE;
                end
            end
            STATE_ENABLE: begin
                shift_ena <= 1'b1;
                if (shift_ena == 1'b1 && shift_ena == 4'b0000) begin
                    shift_ena <= 1'b0;
                end
            end
        endcase
    end
end

endmodule
