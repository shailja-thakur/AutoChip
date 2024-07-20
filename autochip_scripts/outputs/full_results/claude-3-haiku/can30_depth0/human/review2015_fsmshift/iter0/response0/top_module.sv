module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam SHIFT_CYCLES = 4;

reg [1:0] state;
localparam IDLE = 2'b00;
localparam SHIFT = 2'b01;

always @(posedge clk) begin
    if (reset) begin
        state <= SHIFT;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            SHIFT: begin
                if (shift_ena == 1'b1 && SHIFT_CYCLES == 4) begin
                    shift_ena <= 1'b0;
                    state <= IDLE;
                end
                else begin
                    shift_ena <= 1'b1;
                    state <= SHIFT;
                end
            end
            IDLE: begin
                shift_ena <= 1'b0;
                state <= IDLE;
            end
            default: begin
                shift_ena <= 1'b0;
                state <= IDLE;
            end
        endcase
    end
end

endmodule
