module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam [1:0] IDLE = 2'd0, CONVERT = 2'd1, DONE = 2'd2;
reg [1:0] state, next_state;
reg [7:0] num, complement;
reg [3:0] count;

always @(posedge clk, posedge areset) begin
    if (areset)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        IDLE: begin
            if (!areset)
                next_state = CONVERT;
            else
                next_state = IDLE;
            z = 1'b0;
            num = 8'd0;
            complement = 8'd0;
            count = 4'd0;
        end
        CONVERT: begin
            if (count == 4'd7) begin
                next_state = DONE;
                complement = ~num + 1'b1;
            end
            else begin
                next_state = CONVERT;
                num = {num[6:0], x};
                count = count + 4'd1;
            end
            z = complement[count];
        end
        DONE: begin
            next_state = IDLE;
            z = 1'b0;
        end
        default: begin
            next_state = IDLE;
            z = 1'b0;
        end
    endcase
end

endmodule
