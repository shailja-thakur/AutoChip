module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // State encoding
    localparam A = 6'b000001;
    localparam B = 6'b000010;
    localparam C = 6'b000100;
    localparam D = 6'b001000;
    localparam E = 6'b010000;
    localparam F = 6'b100000;

    // Logic for Y1 (input to state flip-flop y[1])
    // Y1 is '1' when transitioning to state B. This happens when:
    // 1. Current state is A and input w is '1' (A --1--> B)
    assign Y1 = (y == A) & w;

    // Logic for Y3 (input to state flip-flop y[3])
    // Y3 is '1' when transitioning to state D. This happens when:
    // 1. Current state is B and input w is '0' (B --0--> D)
    // 2. Current state is C and input w is '0' (C --0--> D)
    // 3. Current state is D and input w is '0' (D --0--> A)
    // 4. Current state is E and input w is '0' (E --0--> D)
    // 5. Current state is F and input w is '0' (F --0--> D)
    assign Y3 = ((y == B) & ~w) | ((y == C) & ~w) | ((y == D) & ~w) | ((y == E) & ~w) | ((y == F) & ~w);

endmodule
