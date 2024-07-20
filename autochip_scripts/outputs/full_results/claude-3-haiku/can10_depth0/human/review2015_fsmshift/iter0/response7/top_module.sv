module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam CYCLE_COUNT = 4;

reg [1:0] state;
localparam IDLE = 2'b00,
          SHIFT_ACTIVE = 2'b01,
          SHIFT_COMPLETE = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            IDLE: begin
                shift_ena <= 1'b1;
                state <= SHIFT_ACTIVE;
            end
            SHIFT_ACTIVE: begin
                shift_ena <= 1'b1;
                if (CYCLE_COUNT == 4) begin
                    state <= SHIFT_COMPLETE;
                end
            end
            SHIFT_COMPLETE: begin
                shift_ena <= 1'b0;
                state <= IDLE;
            end
        endcase
    end
end

endmodule
