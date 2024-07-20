module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam [1:0] STATE_IDLE   = 2'b00,
                 STATE_FIRST  = 2'b01,
                 STATE_SECOND = 2'b10;

reg [1:0] current_state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        current_state <= STATE_IDLE;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    next_state = current_state;
    case (current_state)
        STATE_IDLE: begin
            if (x == 1'b1) begin
                next_state = STATE_FIRST;
            end
            z = 1'b0;
        end
        STATE_FIRST: begin
            if (x == 1'b0) begin
                next_state = STATE_SECOND;
            end
            else begin
                next_state = STATE_FIRST;
            end
            z = 1'b0;
        end
        STATE_SECOND: begin
            if (x == 1'b1) begin
                next_state = STATE_FIRST;
                z = 1'b1;
            end
            else begin
                next_state = STATE_IDLE;
                z = 1'b0;
            end
        end
    endcase
end

endmodule
