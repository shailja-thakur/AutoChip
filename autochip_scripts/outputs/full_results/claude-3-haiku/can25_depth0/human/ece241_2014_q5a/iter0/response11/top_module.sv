module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 2'b00, CALC = 2'b01, DONE = 2'b11;
reg [1:0] state, next_state;
reg [7:0] input_reg, complement;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        input_reg <= 0;
        complement <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        input_reg <= {input_reg[6:0], x};
        complement <= complement;
        z <= (state == DONE) ? ~complement + 1 : 0;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            next_state = (x) ? CALC : IDLE;
            complement = 0;
        end
        CALC: begin
            next_state = (input_reg[7]) ? DONE : CALC;
            complement = {complement[6:0], ~x};
        end
        DONE: begin
            next_state = (areset) ? IDLE : DONE;
            complement = complement;
        end
        default: begin
            next_state = IDLE;
            complement = 0;
        end
    endcase
end

endmodule
