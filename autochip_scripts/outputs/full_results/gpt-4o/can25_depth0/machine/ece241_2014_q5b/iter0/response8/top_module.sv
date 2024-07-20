module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    parameter A = 1'b0, B = 1'b1;
    reg state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            case (state)
                A: if (x) state <= B;
                B: state <= B; // State B remains B
            endcase
        end
    end

    always @(state or x) begin
        case (state)
            A: z = x ? 1'b1 : 1'b0;
            B: z = x ? 1'b0 : 1'b1;
        endcase
    end

endmodule
