module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

parameter IDLE = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

always @(posedge clk, negedge aresetn) begin
    if (~aresetn) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(state, x) begin
    case (state)
        IDLE: begin
            if (x == 1'b1) begin
                next_state = S1;
                z = 1'b0;
            end
            else begin
                next_state = IDLE;
                z = 1'b0;
            end
        end
        S1: begin
            if (x == 1'b0) begin
                next_state = S2;
                z = 1'b0;
            end
            else begin
                next_state = S1;
                z = 1'b0;
            end
        end
        S2: begin
            if (x == 1'b1) begin
                next_state = S3;
                z = 1'b1;
            end
            else begin
                next_state = IDLE;
                z = 1'b0;
            end
        end
        S3: begin
            if (x == 1'b0) begin
                next_state = IDLE;
                z = 1'b0;
            end
            else begin
                next_state = S1;
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
