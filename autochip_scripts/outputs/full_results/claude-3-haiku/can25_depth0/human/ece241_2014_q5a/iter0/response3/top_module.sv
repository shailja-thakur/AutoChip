module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam [1:0] IDLE = 2'b00, CONVERT = 2'b01, DONE = 2'b11;
reg [1:0] current_state, next_state;
reg [7:0] complement;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        current_state <= IDLE;
        complement <= 8'b0;
        z <= 1'b0;
    end
    else begin
        current_state <= next_state;
        case (current_state)
            IDLE: begin
                complement <= 8'b0;
                z <= 1'b0;
            end
            CONVERT: begin
                complement <= {complement[6:0], ~x};
                z <= complement[7];
            end
            DONE: begin
                z <= 1'b0;
            end
        endcase
    end
end

always @(*) begin
    case (current_state)
        IDLE: begin
            if (~areset) next_state = CONVERT;
            else next_state = IDLE;
        end
        CONVERT: begin
            if (complement[7]) next_state = DONE;
            else next_state = CONVERT;
        end
        DONE: begin
            next_state = IDLE;
        end
        default: next_state = IDLE;
    endcase
end

endmodule
