module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam S0 = 1'b0, S1 = 1'b1;
reg state, next_state;
reg [7:0] temp_sum;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= S0;
        temp_sum <= 8'b0;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        temp_sum <= temp_sum + {7'b0, ~x};
        z <= temp_sum[7];
    end
end

always @(*) begin
    case (state)
        S0: begin
            if (~areset) begin
                next_state = S1;
            end
            else begin
                next_state = S0;
            end
        end
        S1: begin
            if (areset) begin
                next_state = S0;
            end
            else begin
                next_state = S1;
            end
        end
        default: begin
            next_state = S0;
        end
    endcase
end

endmodule
