module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // State encoding
    localparam [2:0] 
        A = 3'd0,
        B = 3'd1,
        C = 3'd2,
        D = 3'd3,
        E = 3'd4,
        F = 3'd5;
    
    reg [2:0] state, next_state;

    // State transition logic (Next state logic)
    always @(*) begin
        case (state)
            A: next_state = (w == 1'b1) ? B : A;
            B: next_state = (w == 1'b1) ? C : D;
            C: next_state = (w == 1'b1) ? E : D;
            D: next_state = (w == 1'b1) ? F : A;
            E: next_state = (w == 1'b1) ? E : D;
            F: next_state = (w == 1'b1) ? C : D;
            default: next_state = A;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        case (state)
            E, F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
