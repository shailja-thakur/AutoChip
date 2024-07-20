module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);
    
    reg [2:0] state;  // register to store current state
    reg [2:0] next_state;  // register to store next state
    
    always @(posedge clk) begin
        if (~resetn) 
            state <= 3'b000;  // reset state to A
        else
            state <= next_state;  // update state based on next_state
        
        case (state)
            // state A
            3'b000: begin
                if (r[1])
                    next_state = 3'b010;  // next state is B if r[1] is high
                else if (r[2])
                    next_state = 3'b100;  // next state is C if r[2] is high
                else if (r[3])
                    next_state = 3'b001;  // next state is D if r[3] is high
                else
                    next_state = 3'b000;  // next state is A if none of r bits are high
            end
            
            // state B
            3'b010: begin
                if (r[1])
                    next_state = 3'b010;  // next state is B if r[1] is high
                else
                    next_state = 3'b000;  // next state is A if r[1] is low
            end
            
            // state C
            3'b100: begin
                if (r[2])
                    next_state = 3'b100;  // next state is C if r[2] is high
                else
                    next_state = 3'b000;  // next state is A if r[2] is low
            end
            
            // state D
            3'b001: begin
                if (r[3])
                    next_state = 3'b001;  // next state is D if r[3] is high
                else
                    next_state = 3'b000;  // next state is A if r[3] is low
            end
        endcase
    end
    
    assign g[1] = (state == 3'b010);  // set g[1] high if current state is B
    assign g[2] = (state == 3'b100);  // set g[2] high if current state is C
    assign g[3] = (state == 3'b001);  // set g[3] high if current state is D
    assign g[2:1] = 2'b00;  // set g[2:1] low if none of the above conditions are met

endmodule
