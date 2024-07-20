module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    reg [1:0] state, next_state;
    reg z_reg;
    wire x_to_state_A, x_to_state_B;

    assign x_to_state_A = (state == 2'd0) && (x == 1'b0);
    assign x_to_state_B = (state == 2'd0) && (x == 1'b1);

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'd0;
            z_reg <= 1'b0;
        end else begin
            state <= next_state;
            z_reg <= (state == 2'd1) ? 1'b1 : 1'b0;
        end
    end

    always @* begin
        case (state)
            2'd0: next_state = x_to_state_A ? 2'd0 : x_to_state_B ? 2'd1 : 2'd0;
            2'd1: next_state = x_to_state_A ? 2'd1 : x_to_state_B ? 2'd1 : 2'd1;
        endcase
    end

    assign z = z_reg;

endmodule
