module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    // Declare state encoding
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100
    } state_t;
    
    // State register
    reg [2:0] state, next_state;
    
    // Output logic
    always @(*) begin
        case (state)
            D, E: z = 1'b1;
            default: z = 1'b0;
        endcase
    end
    
    // State transition logic
    always @(*) begin
        case (state)
            A: next_state = x ? B : A;
            B: next_state = x ? E : B;
            C: next_state = x ? B : C;
            D: next_state = x ? C : B;
            E: next_state = x ? E : D;
            default: next_state = A;
        endcase
    end
    
    // State register update
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

endmodule
