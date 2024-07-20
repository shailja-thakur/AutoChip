module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam CYCLES = 4;

reg [1:0] state;
localparam RESET = 2'b00, SHIFT = 2'b01, IDLE = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= RESET;
        shift_ena <= 1'b1;
    end else begin
        case (state)
            RESET: begin
                shift_ena <= 1'b1;
                if (CYCLES == 4) begin
                    state <= IDLE;
                    shift_ena <= 1'b0;
                end else begin
                    state <= RESET;
                end
            end
            IDLE: begin
                shift_ena <= 1'b0;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
