module fsm_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State Definitions
    parameter A = 2'd0;
    parameter B = 2'd1;
    parameter C = 2'd2;
    parameter D = 2'd3;
    parameter E = 2'd4;
    parameter F = 2'd5;

    reg [1:0] current_state;
    reg [1:0] next_state;

    always @(posedge clk, posedge reset)
    begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    always @(current_state, w)
    begin
        case (current_state)
            A: if (w == 1)
                   next_state = B;
               else
                   next_state = A;
            B: if (w == 1)
                   next_state = C;
               else
                   next_state = D;
            C: if (w == 1)
                   next_state = E;
               else
                   next_state = D;
            D: if (w == 1)
                   next_state = F;
               else
                   next_state = A;
            E: if (w == 1)
                   next_state = E;
               else
                   next_state = D;
            F: if (w == 1)
                   next_state = C;
               else
                   next_state = D;
        endcase
    end

    always @(current_state)
    begin
        case (current_state)
            A: z = 0;
            B: z = 0;
            C: z = 0;
            D: z = 0;
            E: z = 1;
            F: z = 1;
        endcase
    end

endmodule
module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    fsm_module fsm (
        .clk(clk),
        .reset(reset),
        .w(w),
        .z(z)
    );

endmodule
