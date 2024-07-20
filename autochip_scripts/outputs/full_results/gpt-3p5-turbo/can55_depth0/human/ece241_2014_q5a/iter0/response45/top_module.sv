module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    reg [3:0] state;
    reg [3:0] next_state;
    reg z_reg;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 4'b0000;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            4'b0000: begin // S0 state
                next_state = 4'b0001;
                z_reg = 1'b0;
            end
            4'b0001: begin // S1 state
                next_state = 4'b0010;
                if (x == 1'b1)
                    z_reg = 1'b1;
                else
                    z_reg = 1'b0;
            end
            4'b0010: begin // S2 state
                next_state = 4'b0001;
                z_reg = ~z_reg;
            end
            default: next_state = 4'b0000;
        endcase
    end

    assign z = z_reg;

endmodule
