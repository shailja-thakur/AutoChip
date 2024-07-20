module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;
parameter IDLE = 2'b00, START = 2'b01, FOUND = 2'b10;

always @(posedge clk or negedge aresetn) begin
    if(!aresetn) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case(state)
        IDLE: begin
            z = 0;
            if(x == 1'b1) begin
                next_state = START;
            end
            else begin
                next_state = IDLE;
            end
        end
        START: begin
            z = 0;
            if(x == 1'b0) begin
                next_state = FOUND;
            end
            else begin
                next_state = IDLE;
            end
        end
        FOUND: begin
            z = 1;
            if(x == 1'b1) begin
                next_state = START;
            end
            else begin
                next_state = IDLE;
            end
        end
        default: begin
            z = 0;
            next_state = IDLE;
        end
    endcase
end

endmodule
