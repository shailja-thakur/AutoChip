module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam CYCLES = 4;

reg [1:0] state;
parameter IDLE = 2'b00, ENABLE = 2'b01, DONE = 2'b10;

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
                if (CYCLES == 4) begin
                    state <= DONE;
                end
            end
            DONE: begin
                shift_ena <= 1'b0;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
