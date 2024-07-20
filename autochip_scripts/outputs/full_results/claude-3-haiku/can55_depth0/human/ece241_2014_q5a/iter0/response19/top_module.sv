module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [7:0] accumulator;
reg [2:0] state;

localparam [2:0] IDLE = 3'b000,
                 CONVERT = 3'b001,
                 COMPLETE = 3'b010;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        z <= 0;
        accumulator <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (!areset) begin
                    state <= CONVERT;
                end
            end
            CONVERT: begin
                accumulator <= {accumulator[6:0], x};
                z <= ~x;
                if (accumulator[7]) begin
                    state <= COMPLETE;
                end
            end
            COMPLETE: begin
                z <= 1;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
