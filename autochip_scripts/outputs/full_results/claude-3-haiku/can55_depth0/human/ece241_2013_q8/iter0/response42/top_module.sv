module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

localparam IDLE = 2'b00;
localparam STATE1 = 2'b01;
localparam STATE2 = 2'b10;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= IDLE;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        z <= (state == STATE2 && x == 1'b1) ? 1'b1 : 1'b0;
    end
end

always @(*) begin
    case (state)
        IDLE: next_state = (x == 1'b1) ? STATE1 : IDLE;
        STATE1: next_state = (x == 1'b0) ? STATE2 : IDLE;
        STATE2: next_state = (x == 1'b1) ? STATE1 : IDLE;
        default: next_state = IDLE;
    endcase
end

endmodule
