module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // Define the states
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t state, next;

    // State transition on clock edge
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;     // Reset state
        else
            state <= next;  // Update state
    end

    // Next state logic
    always @(*) begin
        case(state)
            A: begin
                if (r[1])
                    next = B;
                else if (r[2])
                    next = C;
                else if (r[3])
                    next = D;
                else
                    next = A;
            end
            B: begin
                if (r[1])
                    next = B;
                else
                    next = A;
            end
            C: begin
                if (r[2])
                    next = C;
                else
                    next = A;
            end
            D: begin
                if (r[3])
                    next = D;
                else
                    next = A;
            end
            default: next = A;  // Default to initial state
        endcase
    end

    // Output logic based on current state
    always @(*) begin
        g = 3'b000;
        case(state)
            B: g[1] = 1;
            C: g[2] = 1;
            D: g[3] = 1;
            default: g = 3'b000;
        endcase
    end

endmodule
