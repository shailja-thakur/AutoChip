module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

parameter CYCLES = 4;

reg [1:0] state;
localparam IDLE = 2'b00, SHIFT = 2'b01, DONE = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            IDLE: begin
                shift_ena <= 1'b1;
                state <= SHIFT;
            end
            SHIFT: begin
                if (CYCLES == 4) begin
                    shift_ena <= 1'b0;
                    state <= DONE;
                end
                else begin
                    shift_ena <= 1'b1;
                    state <= SHIFT;
                end
            end
            DONE: begin
                shift_ena <= 1'b0;
                state <= DONE;
            end
            default: begin
                state <= IDLE;
                shift_ena <= 1'b0;
            end
        endcase
    end
end

endmodule
