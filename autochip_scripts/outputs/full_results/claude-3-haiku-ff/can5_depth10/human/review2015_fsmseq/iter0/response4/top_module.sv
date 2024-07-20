module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

parameter [1:0] SEARCH = 2'b00,
                FOUND  = 2'b01;

reg [1:0] state, next_state;
reg [3:0] shift_reg;

always @(posedge clk) begin
    if (reset)
        state <= SEARCH;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        SEARCH: begin
            if (shift_reg == 4'b1101)
                next_state = FOUND;
            else begin
                next_state = SEARCH;
                shift_reg = {shift_reg[2:0], data};
            end
        end
        FOUND: begin
            next_state = FOUND;
            start_shifting = 1'b1;
        end
        default: begin
            next_state = SEARCH;
            start_shifting = 1'b0;
        end
    endcase
end

endmodule
