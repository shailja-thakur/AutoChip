module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

localparam IDLE = 2'b00;
localparam FIRST_ONE = 2'b01;
localparam DETECTED = 2'b10;

always @(posedge clk, negedge aresetn) begin
    if (!aresetn)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        IDLE: begin
            z = 1'b0;
            if (x)
                next_state = FIRST_ONE;
            else
                next_state = IDLE;
        end
        FIRST_ONE: begin
            z = 1'b0;
            if (~x)
                next_state = IDLE;
            else
                next_state = DETECTED;
        end
        DETECTED: begin
            z = 1'b1;
            if (x)
                next_state = FIRST_ONE;
            else
                next_state = IDLE;
        end
        default: begin
            z = 1'b0;
            next_state = IDLE;
        end
    endcase
end

endmodule
