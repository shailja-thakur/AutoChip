module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;
parameter IDLE = 2'b00, FIRST_1 = 2'b01, DETECTED = 2'b11;

always @(posedge clk, negedge aresetn) begin
    if(!aresetn)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    case(state)
        IDLE: begin
            if(x)
                next_state = FIRST_1;
            else
                next_state = IDLE;
            z = 1'b0;
        end
        FIRST_1: begin
            if(!x)
                next_state = IDLE;
            else
                next_state = DETECTED;
            z = 1'b0;
        end
        DETECTED: begin
            if(x)
                next_state = FIRST_1;
            else
                next_state = IDLE;
            z = 1'b1;
        end
        default: begin
            next_state = IDLE;
            z = 1'b0;
        end
    endcase
end

endmodule
