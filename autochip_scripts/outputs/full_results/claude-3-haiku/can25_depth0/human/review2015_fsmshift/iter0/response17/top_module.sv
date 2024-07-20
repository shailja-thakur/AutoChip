module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam WAIT_CYCLES = 4;

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        shift_ena <= 1'b1;
    end
    else begin
        state <= next_state;
        if (state == 0 && reset == 1'b0) begin
            shift_ena <= 1'b1;
        end
        else if (state == WAIT_CYCLES - 1) begin
            shift_ena <= 1'b0;
        end
    end
end

always @(*) begin
    case (state)
        0: next_state = 1;
        1: next_state = 2;
        2: next_state = 3;
        3: next_state = 0;
        default: next_state = 0;
    endcase
end

endmodule
