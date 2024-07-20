module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [1:0] state;
reg z_reg;
reg next_state;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
        z_reg <= 1'b0;
    end else begin
        state <= next_state;
        z_reg <= x;
    end
end

always @(state, x) begin
    case(state)
        A: begin
            if (x) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        B: begin
            if (x) begin
                next_state = A;
            end else begin
                next_state = B;
            end
        end
        default: next_state = A;
    endcase
end

assign z = z_reg;

endmodule
