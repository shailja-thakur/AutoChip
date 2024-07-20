module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam STATE_IDLE  = 2'b00;
localparam STATE_ONE   = 2'b01;
localparam STATE_ONE_0 = 2'b10;

reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn) begin
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
                next_state = STATE_ONE;
            end
        end
        STATE_ONE: begin
            if (x == 1'b0) begin
                next_state = STATE_ONE_0;
            end
            else begin
                next_state = STATE_ONE;
            end
        end
        STATE_ONE_0: begin
            if (x == 1'b1) begin
                next_state = STATE_ONE;
                z = 1'b1;
            end
            else begin
                next_state = STATE_IDLE;
            end
        end
    endcase
end

endmodule
