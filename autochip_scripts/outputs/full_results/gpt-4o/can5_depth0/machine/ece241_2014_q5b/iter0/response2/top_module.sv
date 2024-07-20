module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    parameter A = 1'b0, B = 1'b1;
    
    // State register
    reg state;

    // Always block for state transitions
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            case (state)
                A: if (x) state <= B;
                B: state <= B; // State B is a holding state
                default: state <= A;
            endcase
        end
    end

    // Always block for output logic
    always @(*) begin
        case (state)
            A: z = x ? 1 : 0; // In state A, z is set to 1 if x is 1
            B: z = x ? 0 : 1; // In state B, z is set to 1 if x is 0
            default: z = 0;
        endcase
    end

endmodule
