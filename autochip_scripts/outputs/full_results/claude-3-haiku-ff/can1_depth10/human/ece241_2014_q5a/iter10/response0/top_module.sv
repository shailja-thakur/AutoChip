module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam [1:0] 
    IDLE = 2'b00,
    COMPUTE = 2'b01,
    DONE = 2'b10;

reg [1:0] state, next_state;
reg [7:0] input_num, complement;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        input_num <= 8'b0;
        complement <= 8'b0;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        input_num <= {input_num[6:0], x};
        if (state == COMPUTE) begin
            complement <= (~input_num) + 1'b1;
            z <= complement[0];
        end
        else begin
            z <= 1'b0;
        end
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            next_state = (x == 1'b1) ? COMPUTE : IDLE;
        end
        COMPUTE: begin
            next_state = (input_num[7] == 1'b1) ? DONE : COMPUTE;
        end
        DONE: begin
            next_state = IDLE;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
