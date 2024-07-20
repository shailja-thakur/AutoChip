module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

parameter CYCLES = 4;

reg [1:0] state;
localparam [1:0] IDLE = 2'b00, ACTIVE = 2'b01, DONE = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= ACTIVE;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            ACTIVE: begin
                if (shift_ena == 1'b1 && CYCLES == 4) begin
                    state <= DONE;
                    shift_ena <= 1'b0;
                end
                else begin
                    shift_ena <= 1'b1;
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
