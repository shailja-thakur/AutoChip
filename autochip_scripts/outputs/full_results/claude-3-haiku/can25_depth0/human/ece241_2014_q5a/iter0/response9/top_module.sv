module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam STATE_RESET = 2'b00;
localparam STATE_COMPUTE = 2'b01;
localparam STATE_DONE = 2'b11;

reg [1:0] state, next_state;
reg [7:0] accumulator;
reg invert;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= STATE_RESET;
        accumulator <= 0;
        invert <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            STATE_RESET: begin
                accumulator <= 0;
                invert <= 0;
                z <= 0;
            end
            STATE_COMPUTE: begin
                accumulator <= {accumulator[6:0], x};
                if (accumulator[7]) begin
                    invert <= 1;
                end
                z <= (invert) ? ~accumulator[7:0] : accumulator[7:0];
            end
            STATE_DONE: begin
                z <= (invert) ? ~accumulator[7:0] : accumulator[7:0];
            end
        endcase
    end
end

always @(*) begin
    case (state)
        STATE_RESET: begin
            next_state = (areset) ? STATE_RESET : STATE_COMPUTE;
        end
        STATE_COMPUTE: begin
            next_state = (accumulator[7]) ? STATE_DONE : STATE_COMPUTE;
        end
        STATE_DONE: begin
            next_state = (areset) ? STATE_RESET : STATE_DONE;
        end
        default: begin
            next_state = STATE_RESET;
        end
    endcase
end

endmodule
