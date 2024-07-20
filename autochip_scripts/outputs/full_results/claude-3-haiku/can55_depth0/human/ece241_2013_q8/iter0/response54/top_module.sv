module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;
parameter IDLE = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= IDLE;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        if (state == S3 && x == 1'b1)
            z <= 1'b1;
        else
            z <= 1'b0;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (x == 1'b1)
                next_state = S1;
            else
                next_state = IDLE;
        end
        S1: begin
            if (x == 1'b0)
                next_state = S2;
            else
                next_state = IDLE;
        end
        S2: begin
            if (x == 1'b1)
                next_state = S3;
            else
                next_state = IDLE;
        end
        S3: begin
            if (x == 1'b1)
                next_state = S3;
            else
                next_state = IDLE;
        end
        default: next_state = IDLE;
    endcase
end

endmodule
