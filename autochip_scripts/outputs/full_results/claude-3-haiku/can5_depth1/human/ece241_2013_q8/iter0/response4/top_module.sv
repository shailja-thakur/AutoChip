module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;
parameter IDLE = 2'b00, FIRST_1 = 2'b01, SECOND_0 = 2'b10, FOUND = 2'b11;

always @(posedge clk or negedge aresetn) begin
    if(!aresetn) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            z <= 0;
            if (x == 1) begin
                next_state = FIRST_1;
            end
            else begin
                next_state = IDLE;
            end
        end
        FIRST_1: begin
            z <= 0;
            if (x == 0) begin
                next_state = SECOND_0;
            end
            else begin
                next_state = FIRST_1;
            end
        end
        SECOND_0: begin
            z <= 0;
            if (x == 1) begin
                next_state = FOUND;
            end
            else begin
                next_state = IDLE;
            end
        end
        FOUND: begin
            z <= 1;
            next_state = IDLE;
        end
    endcase
end

endmodule
