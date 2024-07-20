module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam [1:0] WAIT = 2'b00, CONVERT = 2'b01, DONE = 2'b10;
reg [1:0] state, next_state;
reg [7:0] input_reg;
reg [7:0] complement;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WAIT;
        input_reg <= 0;
        complement <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        input_reg <= {input_reg[6:0], x};
        complement <= ~input_reg + 1;
        z <= (state == DONE) ? complement[0] : 0;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        WAIT: begin
            if (x) begin
                next_state = CONVERT;
            end
        end
        CONVERT: begin
            if (input_reg[7]) begin
                next_state = DONE;
            end
        end
        DONE: begin
            if (areset) begin
                next_state = WAIT;
            end
        end
    endcase
end

endmodule
