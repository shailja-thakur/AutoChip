module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

reg [1:0] state;
parameter IDLE = 2'd0,
          ENABLE = 2'd1,
          COUNT = 2'd2;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            IDLE: begin
                shift_ena <= 1'b0;
                state <= ENABLE;
            end
            ENABLE: begin
                shift_ena <= 1'b1;
                state <= COUNT;
            end
            COUNT: begin
                if (shift_ena) begin
                    shift_ena <= 1'b1;
                end
                else begin
                    shift_ena <= 1'b0;
                end
                if (shift_ena == 1'b1) begin
                    state <= COUNT;
                end
                else begin
                    state <= IDLE;
                end
            end
            default: begin
                state <= IDLE;
                shift_ena <= 1'b0;
            end
        endcase
    end
end

endmodule
