module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

reg [1:0] state;
localparam IDLE = 2'd0, SHIFT = 2'd1, RESET = 2'd2;

always @(posedge clk) begin
    if (reset) begin
        state <= RESET;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            IDLE: begin
                shift_ena <= 1'b0;
                if (reset) begin
                    state <= RESET;
                end
                else begin
                    state <= SHIFT;
                end
            end
            SHIFT: begin
                shift_ena <= 1'b1;
                if (reset) begin
                    state <= RESET;
                end
                else if (state == SHIFT && shift_ena == 1'b1) begin
                    if (&state) begin
                        state <= IDLE;
                    end
                    else begin
                        state <= state + 1'b1;
                    end
                end
            end
            RESET: begin
                shift_ena <= 1'b1;
                if (reset) begin
                    state <= RESET;
                end
                else begin
                    state <= IDLE;
                end
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
