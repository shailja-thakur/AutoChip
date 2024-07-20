module fsm_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State Definitions
    parameter [1:0] A = 2'b00;
    parameter [1:0] B = 2'b01;
    parameter [1:0] C = 2'b10;
    parameter [1:0] D = 2'b11;
    parameter [1:0] E = 2'b10;
    parameter [1:0] F = 2'b01;

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
            A: if (w)
                   next_state = B;
               else
                   next_state = A;
            B: if (w)
                   next_state = C;
               else
                   next_state = D;
            C: if (w)
                   next_state = E;
               else
                   next_state = D;
            D: if (w)
                   next_state = F;
               else
                   next_state = A;
            E: if (w)
                   next_state = E;
               else
                   next_state = D;
            F: if (w)
                   next_state = C;
               else
                   next_state = D;
        endcase
    end

    always @(current_state)
    begin
        case (current_state)
            A: z = 1'b0;
            B: z = 1'b0;
            C: z = 1'b0;
            D: z = 1'b0;
            E: z = 1'b1;
            F: z = 1'b1;
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
