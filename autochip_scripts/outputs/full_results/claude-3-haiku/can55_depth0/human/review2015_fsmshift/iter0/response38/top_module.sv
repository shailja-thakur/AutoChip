module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam SHIFT_CYCLES = 4;

reg [1:0] state;
localparam [1:0]
    IDLE = 2'd0,
    SHIFT = 2'd1;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            IDLE: begin
                shift_ena <= 1'b1;
                if (SHIFT_CYCLES == 4'd4) begin
                    state <= SHIFT;
                    shift_ena <= 1'b0;
                end
                else begin
                    SHIFT_CYCLES <= SHIFT_CYCLES + 1;
                end
            end
            SHIFT: begin
                shift_ena <= 1'b0;
            end
        endcase
    end
end

endmodule
