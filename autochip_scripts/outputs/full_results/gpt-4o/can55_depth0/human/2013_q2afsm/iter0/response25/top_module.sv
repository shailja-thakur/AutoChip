module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State encoding
    typedef enum logic [1:0] {
        A = 2'd0,
        B = 2'd1,
        C = 2'd2,
        D = 2'd3
    } state_t;
    
    state_t state, next_state;
    
    // State transition (state table)
    always @(*) begin
        case (state)
            A: if (r[1]) 
                   next_state = B;
               else if (r[2] && !r[1]) 
                   next_state = C;
               else if (r[3] && !r[1] && !r[2]) 
                   next_state = D;
               else 
                   next_state = A;
                   
            B: if (r[1]) 
                   next_state = B;
               else 
                   next_state = A;
                   
            C: if (r[2]) 
                   next_state = C;
               else 
                   next_state = A;
                   
            D: next_state = A;
            
            default: next_state = A;
        endcase
    end
    
    // State flip-flops (state register)
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;
        else
            state <= next_state;
    end
    
    // Output logic
    always @(*) begin
        case (state)
            A: g = 3'b000;
            B: g = 3'b001;
            C: g = 3'b010;
            D: g = 3'b100;
            default: g = 3'b000;
        endcase
    end
endmodule
