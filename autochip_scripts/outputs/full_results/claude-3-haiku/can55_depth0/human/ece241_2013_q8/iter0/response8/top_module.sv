module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

parameter IDLE = 2'b00;
parameter WAIT_ONE = 2'b01;
parameter DETECT_ONE = 2'b11;

always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    z = 0;
    case (state)
        IDLE: begin
            if (x == 1'b1) begin
                next_state = WAIT_ONE;
            end
            else begin
                next_state = IDLE;
            end
        end
        WAIT_ONE: begin
            if (x == 1'b0) begin
                next_state = DETECT_ONE;
            end
            else begin
                next_state = WAIT_ONE;
            end
        end
        DETECT_ONE: begin
            if (x == 1'b1) begin
                next_state = WAIT_ONE;
                z = 1'b1;
            end
            else begin
                next_state = IDLE;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
