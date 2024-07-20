module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Define states
    parameter A = 0, B = 1;

    // State register
    reg state;

    // State Machine
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            case (state)
                A: begin
                    if (x)
                        state <= B;
                    else
                        state <= A;
                end
                B: begin
                    state <= B;
                end
                default: state <= A;  // Default state
            endcase
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            A: z = (x) ? 1 : 0;
            B: z = (x) ? 0 : 1;
            default: z = 0;
        endcase
    end

endmodule
