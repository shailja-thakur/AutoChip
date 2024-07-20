module top_module(
    input clk,
    input reset,
    output shift_ena);

reg [2:0] state;
reg [3:0] counter;

parameter IDLE = 0;
parameter SHIFT_ENABLE = 1;

always @(posedge clk) begin
    if (reset)
        state <= IDLE;
    else begin
        case(state)
            IDLE:
                if (/* add condition for detecting proper bit pattern */) begin
                    state <= SHIFT_ENABLE;
                    counter <= 3;
                    shift_ena <= 1;
                end else begin
                    state <= IDLE;
                    shift_ena <= 0;
                end
            SHIFT_ENABLE:
                if (counter > 0) begin
                    state <= SHIFT_ENABLE;
                    counter <= counter - 1;
                    shift_ena <= 1;
                end else begin
                    state <= IDLE;
                    counter <= 0;
                    shift_ena <= 0;
                end
        endcase
    end
end

endmodule
