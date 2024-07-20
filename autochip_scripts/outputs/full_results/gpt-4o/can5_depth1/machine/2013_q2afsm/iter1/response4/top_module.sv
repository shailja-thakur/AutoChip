module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:0] g // Changed to 4-bit to match g[3] indexing
);

    // Define state encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    // State register to store the current state
    reg state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (r[1])
                    next_state = B;
                else if (r[2])
                    next_state = C;
                else if (r[3])
                    next_state = D;
                else
                    next_state = A;
            end

            B: begin
                if (r[1])
                    next_state = B;
                else
                    next_state = A;
            end

            C: begin
                if (r[2])
                    next_state = C;
                else
                    next_state = A;
            end

            D: begin
                if (r[3])
                    next_state = D;
                else
                    next_state = A;
            end
            
            default: next_state = A;
        endcase
    end

    // State register update logic
    always @(posedge clk) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        g = 4'b0000; // Default value
        case (state)
            B: g = 4'b0010;
            C: g = 4'b0100;
            D: g = 4'b1000;
            default: g = 4'b0000;
        endcase
    end
endmodule
