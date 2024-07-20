module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);
    // State definitions
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t state, next;

    // State transition on clock edge
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next;
    end

    // Next state logic
    always_comb begin
        case(state)
            A: 
                if (r[1])
                    next = B;
                else if (r[2])
                    next = C;
                else if (r[3])
                    next = D;
                else
                    next = A;
            B: 
                if (r[1])
                    next = B;
                else
                    next = A;
            C: 
                if (r[2])
                    next = C;
                else
                    next = A;
            D: 
                if (r[3])
                    next = D;
                else
                    next = A;
            default: next = A;
        endcase
    end

    // Output logic
    always_comb begin
        case(state)
            B: g = 3'b010;
            C: g = 3'b100;
            D: g = 3'b001;
            default: g = 3'b000;
        endcase
    end
endmodule
