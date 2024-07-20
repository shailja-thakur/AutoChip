module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam CNT_MAX = 4;

reg [1:0] state;
reg [1:0] next_state;
reg [3:0] cycle_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00;
        cycle_count <= 4'b0000;
        shift_ena <= 1'b0;
    end
    else begin
        state <= next_state;
        case (state)
            2'b00: begin // Reset state
                shift_ena <= 1'b1;
                cycle_count <= CNT_MAX;
                next_state <= 2'b01;
            end
            2'b01: begin // Shift enable state
                if (cycle_count > 0) begin
                    cycle_count <= cycle_count - 1;
                end
                else begin
                    shift_ena <= 1'b0;
                    next_state <= 2'b10;
                end
            end
            2'b10: begin // Wait state
                shift_ena <= 1'b0;
                next_state <= 2'b10; // Stay in wait state until reset
            end
            default: begin
                next_state <= 2'b00;
            end
        endcase
    end
end

endmodule
