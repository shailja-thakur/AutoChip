module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam S_IDLE = 1'b0, S_COMPUTE = 1'b1;
reg state;
reg [7:0] sum;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= S_IDLE;
        sum <= 8'd0;
        z <= 1'b0;
    end
    else begin
        case (state)
            S_IDLE: begin
                if (~areset) begin
                    state <= S_COMPUTE;
                    sum <= 8'd0;
                end
            end
            S_COMPUTE: begin
                sum <= sum + {7'd0, ~x} + 8'd1;
                z <= sum[7];
            end
        endcase
    end
end

endmodule
