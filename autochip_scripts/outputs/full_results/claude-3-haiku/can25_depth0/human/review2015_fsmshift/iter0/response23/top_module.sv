module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

reg [1:0] state;
parameter WAIT = 2'b00, SHIFT = 2'b01, DONE = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            WAIT: begin
                shift_ena <= 1'b1;
                state <= SHIFT;
            end
            SHIFT: begin
                shift_ena <= 1'b1;
                if (state == SHIFT && shift_ena) begin
                    state <= DONE;
                end
            end
            DONE: begin
                shift_ena <= 1'b0;
            end
            default: begin
                state <= WAIT;
            end
        endcase
    end
end

endmodule
