module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam STATE_RESET = 2'b00;
localparam STATE_ENABLE = 2'b01;
localparam STATE_DONE = 2'b10;

reg [1:0] state;
reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_RESET;
        count <= 0;
        shift_ena <= 1'b1;
    end
    else begin
        case (state)
            STATE_RESET: begin
                shift_ena <= 1'b1;
                count <= count + 1;
                if (count == 2'd3) begin
                    state <= STATE_DONE;
                    count <= 0;
                end
            end
            STATE_DONE: begin
                shift_ena <= 1'b0;
            end
            default: begin
                state <= STATE_RESET;
                count <= 0;
                shift_ena <= 1'b1;
            end
        endcase
    end
end

endmodule
