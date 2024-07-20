module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

localparam  [1:0] S_IDLE = 2'b00,
                 S_SEARCH = 2'b01,
                 S_FOUND = 2'b10;

reg [1:0] state, next_state;
reg [3:0] shift_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= S_IDLE;
        start_shifting <= 1'b0;
        shift_reg <= 4'b0;
    end
    else begin
        state <= next_state;
        shift_reg <= {shift_reg[2:0], data};
    end
end

always @(*) begin
    case (state)
        S_IDLE: begin
            if (shift_reg == 4'b1101) begin
                next_state = S_FOUND;
            end
            else begin
                next_state = S_SEARCH;
            end
            start_shifting = 1'b0;
        end
        S_SEARCH: begin
            if (shift_reg == 4'b1101) begin
                next_state = S_FOUND;
            end
            else begin
                next_state = S_SEARCH;
            end
            start_shifting = 1'b0;
        end
        S_FOUND: begin
            next_state = S_FOUND;
            start_shifting = 1'b1;
        end
        default: begin
            next_state = S_IDLE;
            start_shifting = 1'b0;
        end
    endcase
end

endmodule
