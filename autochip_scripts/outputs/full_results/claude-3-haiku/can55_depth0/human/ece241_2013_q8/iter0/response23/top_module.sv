module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;
parameter IDLE = 2'b00, S1 = 2'b01, S10 = 2'b10, S101 = 2'b11;

always @(posedge clk or negedge aresetn) begin
    if(!aresetn) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    z = 0;
    case(state)
        IDLE: begin
            if(x == 1'b1) begin
                next_state = S1;
            end
        end
        S1: begin
            if(x == 1'b0) begin
                next_state = S10;
            end else begin
                next_state = IDLE;
            end
        end
        S10: begin
            if(x == 1'b1) begin
                next_state = S101;
                z = 1;
            end else begin
                next_state = IDLE;
            end
        end
        S101: begin
            if(x == 1'b1) begin
                next_state = S1;
            end else begin
                next_state = IDLE;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
