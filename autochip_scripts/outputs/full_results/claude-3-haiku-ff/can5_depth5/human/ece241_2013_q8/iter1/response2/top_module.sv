module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam STATE_INIT = 2'b00;
localparam STATE_FIRST_1 = 2'b01;
localparam STATE_SECOND_0 = 2'b10;

reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= STATE_INIT;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    z = 1'b0;
    case (state)
        STATE_INIT: begin
            if (x == 1'b1) begin
                next_state = STATE_FIRST_1;
            end
        end
        STATE_FIRST_1: begin
            if (x == 1'b0) begin
                next_state = STATE_SECOND_0;
            end
            else if (x == 1'b1) begin
                next_state = STATE_FIRST_1;
            end
        end
        STATE_SECOND_0: begin
            if (x == 1'b1) begin
                next_state = STATE_FIRST_1;
            end
            else if (x == 1'b0) begin
                next_state = STATE_INIT;
                z = 1'b1;
            end
        end
    endcase
end

endmodule
