module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter IDLE = 2'b00, COMPUTE = 2'b01, DONE = 2'b11;
reg [1:0] state, next_state;
reg [7:0] input_num, complement;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        input_num <= 0;
        complement <= 0;
        z <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                input_num <= 0;
                complement <= 0;
                z <= 0;
            end
            COMPUTE: begin
                input_num <= {input_num[6:0], x};
                complement <= complement + 1;
            end
            DONE: begin
                z <= complement[7];
            end
        endcase
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (~areset) begin
                next_state = COMPUTE;
            end
            else begin
                next_state = IDLE;
            end
        end
        COMPUTE: begin
            if (input_num[7]) begin
                next_state = DONE;
            end
            else begin
                next_state = COMPUTE;
            end
        end
        DONE: begin
            next_state = IDLE;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

endmodule
