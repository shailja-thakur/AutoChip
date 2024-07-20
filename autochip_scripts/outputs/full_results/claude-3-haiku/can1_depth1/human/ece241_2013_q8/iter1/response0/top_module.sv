module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;
parameter IDLE = 2'b00, DETECT_1 = 2'b01, DETECT_01 = 2'b11;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= IDLE;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                z <= 1'b0;
                if (x == 1'b1) begin
                    next_state <= DETECT_1;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            DETECT_1: begin
                z <= 1'b0;
                if (x == 1'b0) begin
                    next_state <= DETECT_01;
                end
                else begin
                    next_state <= DETECT_1;
                end
            end
            DETECT_01: begin
                if (x == 1'b1) begin
                    z <= 1'b1;
                    next_state <= DETECT_1;
                end
                else begin
                    z <= 1'b0;
                    next_state <= IDLE;
                end
            end
            default: begin
                z <= 1'b0;
                next_state <= IDLE;
            end
        endcase
    end
end

endmodule
