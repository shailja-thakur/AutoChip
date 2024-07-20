module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State encoding
    typedef enum {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011
    } state_t;
    
    state_t current_state, next_state;

    // State flip-flops
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // State table
    always @(*) begin
        case (current_state)
            A: begin
                g = 3'b000;
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
                g = 3'b001;
                if (r[1])
                    next_state = B;
                else
                    next_state = A;
            end
            
            C: begin
                g = 3'b010;
                if (r[2])
                    next_state = C;
                else
                    next_state = A;
            end
            
            D: begin
                g = 3'b100;
                next_state = A;
            end
            
            default: begin
                g = 3'b000;
                next_state = A;
            end
        endcase
    end

endmodule
