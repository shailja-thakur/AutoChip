module top_module (
    input clk,
    input resetn,
    input [2:0] r,
    output reg [2:0] g
);

    typedef enum reg [1:0] {A, B, C, D} state_type;
    state_type state, next;

    // State register
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next;
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (r[0])
                    next = B;
                else if (r[1])
                    next = C;
                else if (r[2])
                    next = D;
                else
                    next = A;
            end
            B: begin
                if (r[0])
                    next = B;
                else
                    next = A;
            end
            C: begin
                if (r[1])
                    next = C;
                else
                    next = A;
            end
            D: begin
                if (r[2])
                    next = D;
                else
                    next = A;
            end
            default: next = A;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            B: g = 3'b010;
            C: g = 3'b100;
            D: g = 3'b001;
            default: g = 3'b000;
        endcase
    end

endmodule
