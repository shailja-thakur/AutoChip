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
        shift_ena <= 1'b1;
    end
    else begin
        state <= next_state;
        if (state == ENABLE_CYCLES - 1) begin
            shift_ena <= 1'b0;
        end
    end
end

always @(*) begin
    case (state)
        0: begin
            next_state = 1;
            shift_ena = 1'b1;
        end
        1: begin
            next_state = 2;
            shift_ena = 1'b1;
        end
        2: begin
            next_state = 3;
            shift_ena = 1'b1;
        end
        3: begin
            next_state = 3;
            shift_ena = 1'b1;
        end
        default: begin
            next_state = 0;
            shift_ena = 1'b0;
        end
    endcase
end

endmodule
