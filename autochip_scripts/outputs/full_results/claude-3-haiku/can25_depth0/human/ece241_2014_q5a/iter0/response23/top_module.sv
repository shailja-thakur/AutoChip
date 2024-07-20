module top_module (
    input clk,
    input areset,
    input x,
    output z
);

parameter IDLE = 1'b0, CONVERT = 1'b1;
reg state, next_state;
reg [7:0] temp_number, complement;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        temp_number <= 8'b0;
        complement <= 8'b0;
    end
    else begin
        state <= next_state;
        temp_number <= (state == IDLE) ? 8'b0 : {temp_number[6:0], x};
        complement <= (state == CONVERT) ? ~temp_number + 1'b1 : complement;
    end
end

always @(*) begin
    case (state)
        IDLE: next_state = (x == 1'b0) ? IDLE : CONVERT;
        CONVERT: next_state = (temp_number == 8'b0) ? IDLE : CONVERT;
        default: next_state = IDLE;
    endcase
end

assign z = (state == CONVERT) ? complement[7] : 1'b0;

endmodule
