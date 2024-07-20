module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define the state encoding
localparam STATE_IDLE = 2'b00;
localparam STATE_SEEN_1 = 2'b01;
localparam STATE_SEEN_101 = 2'b11;

// State register
reg [1:0] state, next_state;

always @(posedge clk, negedge aresetn) begin
    if (!aresetn) begin
        state <= STATE_IDLE;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        z <= (state == STATE_SEEN_101);
    end
end

always @(*) begin
    case (state)
        STATE_IDLE: begin
            if (x == 1'b1) begin
                next_state = STATE_SEEN_1;
            end
            else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_SEEN_1: begin
            if (x == 1'b0) begin
                next_state = STATE_IDLE;
            end
            else if (x == 1'b1) begin
                next_state = STATE_SEEN_101;
            end
            else begin
                next_state = STATE_SEEN_1;
            end
        end
        STATE_SEEN_101: begin
            if (x == 1'b0) begin
                next_state = STATE_SEEN_1;
            end
            else if (x == 1'b1) begin
                next_state = STATE_SEEN_101;
            end
            else begin
                next_state = STATE_SEEN_101;
            end
        end
        default: begin
            next_state = STATE_IDLE;
        end
    endcase
end

endmodule
