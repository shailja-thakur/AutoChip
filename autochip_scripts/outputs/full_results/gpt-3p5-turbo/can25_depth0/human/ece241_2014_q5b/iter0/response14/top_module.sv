module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    reg [1:0] state;          // State register
    parameter A = 2'b00;      // State A
    parameter B = 2'b01;      // State B

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;       // Reset to state A
        else begin
            case (state)
                A: begin
                    if (x)
                        state <= B;
                    else
                        state <= A;
                end
                B: begin
                    if (x)
                        state <= B;
                    else
                        state <= B;
                end
                default: state <= A;
            endcase
        end
    end

    always @(state, x) begin
        case (state)
            A: z = 1'b0;
            B: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
