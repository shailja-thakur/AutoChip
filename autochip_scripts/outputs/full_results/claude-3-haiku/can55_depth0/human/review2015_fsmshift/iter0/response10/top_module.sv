module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam SHIFT_CYCLES = 4;

reg [1:0] state;
localparam IDLE = 2'd0;
localparam SHIFT = 2'd1;
localparam RESET = 2'd2;

always @(posedge clk) begin
    if (reset) begin
        state <= RESET;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            IDLE: begin
                shift_ena <= 1'b0;
            end
            SHIFT: begin
                if (shift_ena == 1'b1) begin
                    shift_ena <= 1'b1;
                end
                else begin
                    shift_ena <= 1'b0;
                end
            end
            RESET: begin
                shift_ena <= 1'b1;
                if (SHIFT_CYCLES == 4) begin
                    state <= IDLE;
                end
                else begin
                    SHIFT_CYCLES <= SHIFT_CYCLES + 1;
                end
            end
        endcase
    end
end

endmodule
