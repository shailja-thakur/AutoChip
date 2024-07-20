module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define the states using one-hot encoding
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;
    parameter E = 2'b100;
    parameter F = 2'b101;

    // Declare the state registers
    reg [2:0] state_reg;
    reg [2:0] next_state_reg;

    // State table
    always @(posedge clk)
    begin
        if (reset)
            state_reg <= A;
        else
            state_reg <= next_state_reg;
    end

    // Next state logic
    always @(*)
    begin
        case (state_reg)
            A:
                begin
                    if (w)
                        next_state_reg = B;
                    else
                        next_state_reg = A;
                end
            B:
                begin
                    if (w)
                        next_state_reg = C;
                    else
                        next_state_reg = D;
                end
            C:
                begin
                    if (w)
                        next_state_reg = E;
                    else
                        next_state_reg = D;
                end
            D:
                begin
                    if (w)
                        next_state_reg = F;
                    else
                        next_state_reg = A;
                end
            E:
                begin
                    if (w)
                        next_state_reg = E;
                    else
                        next_state_reg = D;
                end
            F:
                begin
                    if (w)
                        next_state_reg = C;
                    else
                        next_state_reg = D;
                end
            default:
                next_state_reg = A;
        endcase
    end

    // Output assignment
    always @(state_reg)
    begin
        case (state_reg)
            A:
                z = 0;
            E:
                z = 1;
            default:
                z = z;
        endcase
    end

endmodule
