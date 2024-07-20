module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);
    // States encoding
    reg [2:0] state, next_state;
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;

    // Sequential block
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= A;
        else 
            state <= next_state;
    end

    // Combinational block
    always @(*) begin
        case (state)
            A: if (x) next_state = B; else next_state = A;
            B: if (x) next_state = E; else next_state = B;
            C: if (x) next_state = B; else next_state = C;
            D: if (x) next_state = C; else next_state = B;
            E: if (x) next_state = E; else next_state = D;
            default: next_state = A;  // Default state
        endcase
    end

    // Output logic
    always @(state) begin
        case (state)
            D, E: z = 1;
            default: z = 0;
        endcase
    end

endmodule
