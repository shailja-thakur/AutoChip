module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam [1:0] 
    STATE_0 = 2'b00,
    STATE_1 = 2'b01,
    STATE_2 = 2'b10;

reg [1:0] state, next_state;

always @(posedge clk, negedge aresetn) begin
    if (~aresetn) begin
        state <= STATE_0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        STATE_0: begin
            z = 1'b0;
            if (x) begin
                next_state = STATE_1;
            end
        end
        STATE_1: begin
            z = 1'b0;
            if (x) begin
                next_state = STATE_2;
            end
            else begin
                next_state = STATE_0;
            end
        end
        STATE_2: begin
            z = 1'b1;
            if (x) begin
                next_state = STATE_1;
            end
            else begin
                next_state = STATE_0;
            end
        end
    endcase
end

endmodule
