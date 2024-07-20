module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam STATE_INIT  = 2'b00;
localparam STATE_ONE   = 2'b01;
localparam STATE_ZERO  = 2'b10;

reg [1:0] state, next_state;

always @(posedge clk, negedge aresetn) begin
    if (!aresetn) begin
        state <= STATE_INIT;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        STATE_INIT: begin
            z = 0;
            if (x == 1'b1) begin
                next_state = STATE_ONE;
            end else begin
                next_state = STATE_INIT;
            end
        end
        STATE_ONE: begin
            z = 0;
            if (x == 1'b0) begin
                next_state = STATE_ZERO;
            end else begin
                next_state = STATE_ONE;
            end
        end
        STATE_ZERO: begin
            if (x == 1'b1) begin
                z = 1;
                next_state = STATE_ONE;
            end else begin
                z = 0;
                next_state = STATE_INIT;
            end
        end
        default: begin
            z = 0;
            next_state = STATE_INIT;
        end
    endcase
end

endmodule
