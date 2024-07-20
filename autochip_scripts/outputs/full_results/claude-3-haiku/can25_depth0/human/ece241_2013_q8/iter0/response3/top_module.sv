module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;
localparam IDLE = 2'b00, WAIT_ONE = 2'b01, DETECT = 2'b11;

always @(posedge clk, negedge aresetn) begin
    if (!aresetn) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            z = 1'b0;
            if (x) begin
                next_state = WAIT_ONE;
            end
            else begin
                next_state = IDLE;
            end
        end
        WAIT_ONE: begin
            z = 1'b0;
            if (x) begin
                next_state = DETECT;
            end
            else begin
                next_state = IDLE;
            end
        end
        DETECT: begin
            if (x) begin
                z = 1'b1;
                next_state = WAIT_ONE;
            end
            else begin
                z = 1'b0;
                next_state = IDLE;
            end
        end
        default: begin
            z = 1'b0;
            next_state = IDLE;
        end
    endcase
end

endmodule
