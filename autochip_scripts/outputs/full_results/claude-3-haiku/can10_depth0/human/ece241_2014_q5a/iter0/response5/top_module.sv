module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

localparam S0 = 1'b0, S1 = 1'b1;
reg state, next_state;
reg [7:0] data, neg_data;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= S0;
        data <= 8'd0;
        neg_data <= 8'd0;
    end
    else begin
        state <= next_state;
        data <= {data[6:0], x};
        neg_data <= ~data + 1'b1;
    end
end

always @(*) begin
    case (state)
        S0: begin
            z = 1'b0;
            next_state = (areset) ? S0 : S1;
        end
        S1: begin
            z = neg_data[0];
            next_state = (data[7:0] == 8'd0) ? S0 : S1;
        end
        default: begin
            z = 1'b0;
            next_state = S0;
        end
    endcase
end

endmodule
