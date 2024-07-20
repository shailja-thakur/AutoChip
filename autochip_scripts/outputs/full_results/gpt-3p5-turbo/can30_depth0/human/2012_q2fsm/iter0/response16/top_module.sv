module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    // State codes
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;
    parameter E = 2'b100;
    parameter F = 2'b101;

    // State register
    reg [1:0] state_reg;
    
    // Next state logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            state_reg <= A;
        else begin
            case (state_reg)
                A: begin
                    if (w)
                        state_reg <= B;
                    else
                        state_reg <= A;
                end
                B: begin
                    if (w)
                        state_reg <= C;
                    else
                        state_reg <= D;
                end
                C: begin
                    if (w)
                        state_reg <= E;
                    else
                        state_reg <= D;
                end
                D: begin
                    if (w)
                        state_reg <= F;
                    else
                        state_reg <= A;
                end
                E: begin
                    if (w)
                        state_reg <= E;
                    else
                        state_reg <= D;
                end
                F: begin
                    if (w)
                        state_reg <= C;
                    else
                        state_reg <= D;
                end
                default: state_reg <= A;
            endcase
        end
    end

    // Output assignment
    always @(state_reg) begin
        case (state_reg)
            A: z = 0;
            E: z = 1;
            default: z = 0;
        endcase
    end

endmodule
