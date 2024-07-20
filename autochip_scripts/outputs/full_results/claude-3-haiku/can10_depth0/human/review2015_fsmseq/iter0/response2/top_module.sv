module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

parameter [1:0] IDLE = 2'b00;
parameter [1:0] SEARCH = 2'b01;
parameter [1:0] FOUND = 2'b11;

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
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (shift_reg == 4'b1101) begin
                next_state = FOUND;
            end
            else begin
                next_state = SEARCH;
            end
        end
        SEARCH: begin
            if (shift_reg == 4'b1101) begin
                next_state = FOUND;
            end
            else begin
                next_state = SEARCH;
            end
        end
        FOUND: begin
            next_state = FOUND;
            start_shifting = 1'b1;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
