module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;
parameter IDLE = 2'b00, DETECT_FIRST_1 = 2'b01, DETECT_0 = 2'b10, DETECT_SECOND_1 = 2'b11;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= IDLE;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    z = 1'b0;
    case (state)
        IDLE: begin
            if (x == 1'b1) begin
                next_state = DETECT_FIRST_1;
            end
        end
        DETECT_FIRST_1: begin
            if (x == 1'b0) begin
                next_state = DETECT_0;
            end
            else if (x == 1'b1) begin
                next_state = DETECT_FIRST_1;
            end
        end
        DETECT_0: begin
            if (x == 1'b1) begin
                next_state = DETECT_SECOND_1;
                z = 1'b1;
            end
            else if (x == 1'b0) begin
                next_state = DETECT_0;
            end
        end
        DETECT_SECOND_1: begin
            if (x == 1'b0 || x == 1'b1) begin
                next_state = DETECT_FIRST_1;
            end
        end
    endcase
end

endmodule
