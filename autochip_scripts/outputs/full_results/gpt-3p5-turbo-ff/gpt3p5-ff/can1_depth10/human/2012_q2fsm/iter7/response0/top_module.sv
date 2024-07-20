module fsm (
    input clk,
    input reset,
    input w,
    output reg z
);

    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;

    reg [1:0] state;
    reg [1:0] next_state;

    // state table
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // state flip-flops
    always @(state or w) begin
        case (state)
        A: begin
            if (w)
                next_state = B;
            else
                next_state = A;
        end
        B: begin
            if (w)
                next_state = C;
            else
                next_state = D;
        end
        C: begin
            if (w)
                next_state = E;
            else
                next_state = D;
        end
        D: begin
            if (w)
                next_state = F;
            else
                next_state = A;
        end
        E: begin
            if (w)
                next_state = E;
            else
                next_state = D;
        end
        F: begin
            if (w)
                next_state = C;
            else
                next_state = D;
        end
        endcase
    end

    // FSM output
    always @(state) begin
        case (state)
        A, B, C, D: z <= 0;
        E, F: z <= 1;
        endcase
    end

endmodule
module top_module (
    input clk,
    input reset,
    input w,
    output wire z
);

    fsm fsm_inst (
        .clk(clk),
        .reset(reset),
        .w(w),
        .z(z)
    );

endmodule
