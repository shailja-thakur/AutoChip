module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam RESET_COUNT = 4;

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        shift_ena <= 1'b1;
    end
    else begin
        state <= next_state;
        if (state == RESET_COUNT - 1) begin
            shift_ena <= 1'b0;
        end
    end
end

always @(*) begin
    case (state)
        2'b00: next_state = 2'b01;
        2'b01: next_state = 2'b10;
        2'b10: next_state = 2'b11;
        2'b11: next_state = 2'b00;
        default: next_state = 2'b00;
    endcase
end

endmodule
