module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
    // Define state enumeration
    typedef enum logic [1:0] {
        A, B, C, D
    } state_t;
    
    // Define state signals
    reg state_t present_state, next_state;
    
    // Define output signals
    wire [3:1] g_temp;
    
    // State flip-flops
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            present_state <= A;
        else
            present_state <= next_state;
    end
    
    // State transition logic
    always @(present_state, r) begin
        case (present_state)
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
                if (r[1] && g_temp[1])
                    next_state = B;
                else if (r[1])
                    next_state = B;
                else
                    next_state = A;
            end
            
            C: begin
                if (r[2] && g_temp[2])
                    next_state = C;
                else if (r[2])
                    next_state = C;
                else
                    next_state = A;
            end
            
            D: begin
                if (g_temp[3])
                    next_state = D;
                else if (r[1] || r[2] || r[3])
                    next_state = A;
                else
                    next_state = D;
            end
        endcase
    end
    
    // Output logic
    always @(present_state) begin
        case (present_state)
            A: g_temp = 3'b000;
            B: g_temp = 3'b100;
            C: g_temp = 3'b010;
            D: g_temp = 3'b001;
        endcase
    end
    
    // Assign g output
    assign g = g_temp;
    
endmodule
