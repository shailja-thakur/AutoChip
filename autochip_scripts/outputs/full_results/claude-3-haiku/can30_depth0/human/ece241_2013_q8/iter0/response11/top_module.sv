module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam [1:0] IDLE = 2'b00, STATE1 = 2'b01, STATE2 = 2'b10;
reg [1:0] state, next_state;

always @(posedge clk, negedge aresetn) begin
    if (!aresetn) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    z = 1'b0;

    case (state)
        IDLE: begin
            if (x) begin
                next_state = STATE1;
            end
        end
        STATE1: begin
            if (!x) begin
                next_state = STATE2;
            end
            else begin
                next_state = IDLE;
            end
        end
        STATE2: begin
            if (x) begin
                next_state = IDLE;
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
