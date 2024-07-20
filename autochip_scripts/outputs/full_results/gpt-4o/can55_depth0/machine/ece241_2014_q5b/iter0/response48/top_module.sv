module top_module (
    input clk,
    input areset,
    input x,
    output z
);
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;
    reg z_reg;
    
    assign z = z_reg;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A: begin
                if (x)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                next_state = B;
            end
            default: next_state = A;
        endcase
    end

    // State update logic (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic (combinational)
    always @(*) begin
        case (state)
            A: z_reg = x ? 1'b1 : 1'b0;
            B: z_reg = x ? 1'b0 : 1'b1;
            default: z_reg = 1'b0;
        endcase
    end
endmodule
