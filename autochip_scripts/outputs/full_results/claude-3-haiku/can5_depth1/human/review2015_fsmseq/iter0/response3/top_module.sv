module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam [1:0] IDLE = 2'b00,
                 SEARCH = 2'b01,
                 FOUND = 2'b10;

reg [1:0] state, next_state;
reg [3:0] shift_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 1'b0;
        shift_reg <= 4'b0;
    end
    else begin
        state <= next_state;
        shift_reg <= {shift_reg[2:0], data};
        if (state == FOUND)
            start_shifting <= 1'b1;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        IDLE: begin
            if (shift_reg == 4'b1101)
                next_state = FOUND;
            else
                next_state = SEARCH;
        end
        SEARCH: begin
            if (shift_reg == 4'b1101)
                next_state = FOUND;
        end
        FOUND: begin
            // Stay in FOUND state
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
