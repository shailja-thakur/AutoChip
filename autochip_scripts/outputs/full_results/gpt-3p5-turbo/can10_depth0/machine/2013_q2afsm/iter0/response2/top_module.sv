module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);
    
    reg [3:1] state;
    reg [3:1] next;
    
    always @(posedge clk) begin
        if (!resetn)
            state <= 3'b001;  // Set state to A
        else
            state <= next;   // Set state to next state
    end
    
    always @* begin
        case (state)
            3'b001: begin  // State A
                if (r[1])
                    next = 3'b010;  // Next state is B
                else if (r[2])
                    next = 3'b011;  // Next state is C
                else if (r[3])
                    next = 3'b100;  // Next state is D
                else
                    next = 3'b001;  // Next state is A
            end
            
            3'b010: begin  // State B
                if (r[1])
                    next = 3'b010;  // Next state is B
                else
                    next = 3'b001;  // Next state is A
            end
            
            3'b011: begin  // State C
                if (r[2])
                    next = 3'b011;  // Next state is C
                else
                    next = 3'b001;  // Next state is A
            end
            
            3'b100: begin  // State D
                if (r[3])
                    next = 3'b100;  // Next state is D
                else
                    next = 3'b001;  // Next state is A
            end
        endcase
    end
    
    always @* begin
        case (state)
            3'b010: g = 3'b001;  // State B, g[1] is high
            3'b011: g = 3'b010;  // State C, g[2] is high
            3'b100: g = 3'b100;  // State D, g[3] is high
            default: g = 3'b000;  // All other states, all bits are low
        endcase
    end

endmodule
