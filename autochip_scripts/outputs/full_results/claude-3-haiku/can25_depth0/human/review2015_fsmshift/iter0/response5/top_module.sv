module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam CYCLES = 4;

reg [1:0] state;
parameter IDLE = 2'b00, SHIFT = 2'b01, DONE = 2'b10;

always @(posedge clk or negedge reset) begin
    if (!reset) begin
        state <= IDLE;
        shift_ena <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                shift_ena <= 1'b1;
                state <= SHIFT;
            end
            SHIFT: begin
                if (CYCLES == 0) begin
                    shift_ena <= 1'b0;
                    state <= DONE;
                end
                else begin
                    CYCLES <= CYCLES - 1;
                end
            end
            DONE: begin
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
