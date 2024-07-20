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
    
    state_t state, next_state;
    
    // State transition always block
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= A;  // Reset to state A
        else
            state <= next_state;
    end
    
    // State table always block
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
                next_state = A;  // D does not remain in D as it only grants request for r3 temporarily
            end
            default: next_state = A;
        endcase
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
