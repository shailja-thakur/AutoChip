module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    // State encoding
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;
    parameter E = 2'b00;
    parameter F = 2'b01;

    // Declare state register
    reg [1:0] current_state;

    // Declare next state register
    reg [1:0] next_state;

    // State flip-flop
    always @(posedge clk, posedge reset)
    begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // State table
    always @(current_state, w)
    begin
        case (current_state)
            A:
                if (w)
                    next_state = B;
                else
                    next_state = A;
            B:
                if (w)
                    next_state = C;
                else
                    next_state = D;
            C:
                if (w)
                    next_state = E;
                else
                    next_state = D;
            D:
                if (w)
                    next_state = F;
                else
                    next_state = A;
            E:
                if (w)
                    next_state = E;
                else
                    next_state = D;
            F:
                if (w)
                    next_state = C;
                else
                    next_state = D;
        endcase
    end

    // Output z
    always @(current_state)
    begin
        case (current_state)
            E: z = 1;
            default: z = 0;
        endcase
    end

endmodule
