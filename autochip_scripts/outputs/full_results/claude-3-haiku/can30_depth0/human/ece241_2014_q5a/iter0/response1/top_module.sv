module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states of the state machine
parameter [1:0] IDLE = 2'b00, COMPUTE = 2'b01, DONE = 2'b11;
reg [1:0] state, next_state;
reg [7:0] input_num, complement;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= IDLE;
        input_num <= 8'b0;
        complement <= 8'b0;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        input_num <= {input_num[6:0], x};
        if (state == COMPUTE) begin
            complement <= ~input_num + 1'b1;
        end
    end
end

always @(*) begin
    case (state)
        IDLE:
            if (!areset) begin
                next_state = COMPUTE;
            end
            else begin
                next_state = IDLE;
            end
        COMPUTE:
            if (areset) begin
                next_state = IDLE;
            end
            else begin
                next_state = DONE;
            end
        DONE:
            next_state = IDLE;
        default:
            next_state = IDLE;
    endcase

    case (state)
        IDLE:
            z = 1'b0;
        COMPUTE:
            z = complement[0];
        DONE:
            z = 1'b0;
        default:
            z = 1'b0;
    endcase
end

endmodule
