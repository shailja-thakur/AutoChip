module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

localparam STATE_IDLE = 2'b00,
          STATE_GOT_1 = 2'b01,
          STATE_GOT_01 = 2'b10;

always @(posedge clk, negedge aresetn) begin
    if (!aresetn) begin
        state <= STATE_IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    z = 1'b0;

    case (state)
        STATE_IDLE: begin
            if (x == 1'b1) begin
                next_state = STATE_GOT_1;
            end
        end
        STATE_GOT_1: begin
            if (x == 1'b0) begin
                next_state = STATE_GOT_01;
            end
            else begin
                next_state = STATE_GOT_1;
            end
        end
        STATE_GOT_01: begin
            if (x == 1'b1) begin
                next_state = STATE_GOT_1;
                z = 1'b1;
            end
            else begin
                next_state = STATE_IDLE;
            end
        end
        default: begin
            next_state = STATE_IDLE;
        end
    endcase
end

endmodule
