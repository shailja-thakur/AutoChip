module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State encoding
    typedef enum reg [1:0] {
        S_A = 2'b00,
        S_B = 2'b01,
        S_C = 2'b10,
        S_D = 2'b11
    } state_t;

    // State registers
    reg [1:0] state, next;

    // State transition logic
    always @(*) begin
        case (state)
            S_A: begin
                if (r[1])
                    next = S_B;
                else if (r[2])
                    next = S_C;
                else if (r[3])
                    next = S_D;
                else
                    next = S_A;
            end
            S_B: begin
                if (r[1])
                    next = S_B;
                else
                    next = S_A;
            end
            S_C: begin
                if (r[2])
                    next = S_C;
                else
                    next = S_A;
            end
            S_D: begin
                if (r[3])
                    next = S_D;
                else
                    next = S_A;
            end
            default: next = S_A;
        endcase
    end

    // State register update
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= S_A;
        else
            state <= next;
    end

    // Output logic
    always @(*) begin
        g = 3'b000; // Default to all bits low
        case (state)
            S_B: g[1] = 1;
            S_C: g[2] = 1;
            S_D: g[3] = 1;
        endcase
    end

endmodule
