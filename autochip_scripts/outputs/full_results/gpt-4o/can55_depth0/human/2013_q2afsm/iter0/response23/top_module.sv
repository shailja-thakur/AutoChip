module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);
    
    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;
    
    state_t current_state, next_state;
    
    // State flip-flops
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= A;  // Reset to state A
        end else begin
            current_state <= next_state;
        end
    end
    
    // State table (Next state logic)
    always @(*) begin
        case (current_state)
            A: begin
                if (r[1]) next_state = B;
                else if (r[2]) next_state = C;
                else if (r[3]) next_state = D;
                else next_state = A;
            end
            B: begin
                if (r[1]) next_state = B;
                else next_state = A;
            end
            C: begin
                if (r[2]) next_state = C;
                else next_state = A;
            end
            D: begin
                next_state = A;  // Since there's no further transition defined, return to A
            end
            default: next_state = A;  // Default case
        endcase
    end
    
    // Output logic (Continuous assignment or inside always block)
    always @(*) begin
        g = 3'b000;  // Default output to 0
        case (current_state)
            B: g[1] = 1;  // Grant to r1
            C: g[2] = 1;  // Grant to r2
            D: g[3] = 1;  // Grant to r3
            default: g = 3'b000;  // Default case
        endcase
    end

endmodule
