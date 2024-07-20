module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam STATE_IDLE = 2'b00;
localparam STATE_CONVERT = 2'b01;
localparam STATE_DONE = 2'b10;

reg [1:0] state, next_state;
reg [7:0] data, next_data;
reg carry, next_carry;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_IDLE;
        data <= 0;
        carry <= 0;
    end
    else begin
        state <= next_state;
        data <= next_data;
        carry <= next_carry;
    end
end

always @(*) begin
    next_state = state;
    next_data = data;
    next_carry = carry;
    z = 0;

    case (state)
        STATE_IDLE: begin
            if (~areset) begin
                next_state = STATE_CONVERT;
                next_data = 0;
                next_carry = 0;
            end
        end
        STATE_CONVERT: begin
            next_data = {data[6:0], x};
            next_carry = (data[7] & ~x) | (data[7] & carry) | (carry & ~x);
            if (data[7] & carry) begin
                next_state = STATE_DONE;
                z = ~data + 1'b1;
            end
        end
        STATE_DONE: begin
            if (areset) begin
                next_state = STATE_IDLE;
            end
        end
    endcase
end

endmodule
