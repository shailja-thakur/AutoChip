module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

    reg [3:1] state;
    reg [3:1] next_state;
    
    always @ (posedge clk or negedge resetn) begin
        if (!resetn)
            state <= 3'b000;  // Set state to A when reset is low
        else
            state <= next_state;  // Set state to next state
        
        case (state)
            3'b000: begin  // State A
                if (r[1])
                    next_state = 3'b001;  // Next state is B if r[1] is high
                else if (r[2])
                    next_state = 3'b010;  // Next state is C if r[2] is high
                else if (r[3])
                    next_state = 3'b011;  // Next state is D if r[3] is high
                else
                    next_state = 3'b000;  // Next state is A if none of the bits are high
            end
            
            3'b001: begin  // State B
                if (r[1])
                    next_state = 3'b001;  // Next state is B if r[1] is high
                else
                    next_state = 3'b000;  // Next state is A if r[1] is low
            end
            
            3'b010: begin  // State C
                if (r[2])
                    next_state = 3'b010;  // Next state is C if r[2] is high
                else
                    next_state = 3'b000;  // Next state is A if r[2] is low
            end
            
            3'b011: begin  // State D
                if (r[3])
                    next_state = 3'b011;  // Next state is D if r[3] is high
                else
                    next_state = 3'b000;  // Next state is A if r[3] is low
            end
        endcase
    end

    assign g[1] = (state == 3'b001);  // g[1] is high if current state is B
    assign g[2] = (state == 3'b010);  // g[2] is high if current state is C
    assign g[3] = (state == 3'b011);  // g[3] is high if current state is D
endmodule
