module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam [1:0] S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
reg [1:0] state, next_state;
reg [7:0] sum;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= S0;
        sum <= 8'b0;
    end
    else begin
        state <= next_state;
        sum <= sum + {7'b0, ~x};
    end
end

always @(*) begin
    case (state)
        S0: begin
            z = 1'b0;
            next_state = x ? S1 : S0;
        end
        S1: begin
            z = sum[0];
            next_state = x ? S1 : S2;
        end
        S2: begin
            z = sum[0];
            next_state = x ? S1 : S2;
        end
        default: begin
            z = 1'bx;
            next_state = S0;
        end
    endcase
end

endmodule
