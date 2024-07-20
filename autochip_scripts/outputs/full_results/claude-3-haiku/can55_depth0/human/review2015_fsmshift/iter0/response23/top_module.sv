module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam ENABLE_CYCLES = 4;

reg [1:0] state;
localparam IDLE = 2'd0,
          ENABLE = 2'd1;

always @(posedge clk) begin
    if (reset) begin
        state <= ENABLE;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            ENABLE: begin
                if (shift_ena == 1'b1 && ENABLE_CYCLES == 4'd4) begin
                    state <= IDLE;
                    shift_ena <= 1'b0;
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
