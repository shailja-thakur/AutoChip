module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;
parameter IDLE = 2'b00, DETECT_0 = 2'b01, DETECT_1 = 2'b10;

always @(posedge clk, negedge aresetn) begin
    if (~aresetn) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (x == 1'b0) begin
                next_state = DETECT_0;
                z = 1'b0;
            end
            else begin
                next_state = IDLE;
                z = 1'b0;
            end
        end
        DETECT_0: begin
            if (x == 1'b1) begin
                next_state = DETECT_1;
                z = 1'b0;
            end
            else begin
                next_state = IDLE;
                z = 1'b0;
            end
        end
        DETECT_1: begin
            if (x == 1'b0) begin
                next_state = IDLE;
                z = 1'b1;
            end
            else begin
                next_state = DETECT_0;
                z = 1'b0;
            end
        end
        default: begin
            next_state = IDLE;
            z = 1'b0;
        end
    endcase
end

endmodule
