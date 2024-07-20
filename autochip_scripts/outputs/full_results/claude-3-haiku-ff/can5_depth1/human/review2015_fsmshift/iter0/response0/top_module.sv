module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

localparam ENABLE_CYCLES = 4;

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        shift_ena <= 1;
    end
    else begin
        state <= next_state;
        if (state == 0 && next_state == 1)
            shift_ena <= 1;
        else if (state == 1 && next_state == 2)
            shift_ena <= 1;
        else if (state == 2 && next_state == 3)
            shift_ena <= 1;
        else if (state == 3 && next_state == 0)
            shift_ena <= 0;
        else
            shift_ena <= shift_ena;
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
