module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam CYCLES = 4;

reg [1:0] state;
localparam RESET = 2'b00, SHIFT = 2'b01, IDLE = 2'b10;

integer count;

always @(posedge clk) begin
    if (reset) begin
        state <= RESET;
        shift_ena <= 1'b1;
        count <= 0;
    end else begin
        case (state)
            RESET: begin
                shift_ena <= 1'b1;
                if (count == CYCLES-1) begin
                    state <= IDLE;
                    shift_ena <= 1'b0;
                    count <= 0;
                end else begin
                    count <= count + 1;
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
