module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam STATE_WIDTH = 2;
localparam ENABLE_CYCLES = 4;

reg [STATE_WIDTH-1:0] state;
reg [3:0] cycle_count;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        cycle_count <= 0;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            2'd0: begin // Reset state
                shift_ena <= 1'b1;
                cycle_count <= cycle_count + 1;
                if (cycle_count == ENABLE_CYCLES - 1) begin
                    state <= 2'd1;
                    cycle_count <= 0;
                    shift_ena <= 1'b0;
                end
            end
            2'd1: begin // Shift register enabled state
                shift_ena <= 1'b0;
            end
            default: begin
                state <= 2'd0;
                cycle_count <= 0;
                shift_ena <= 1'b0;
            end
        endcase
    end
end

endmodule
