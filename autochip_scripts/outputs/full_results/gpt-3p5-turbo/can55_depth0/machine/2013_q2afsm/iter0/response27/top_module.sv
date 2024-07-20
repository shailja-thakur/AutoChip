module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

    reg [3:1] state;
    reg [3:1] next;
    
    always @(posedge clk) begin
        if (!resetn)
            state <= 3'b001;  // set state to A
        else
            state <= next;    // update state with next state
    end

    always @(*) begin
        case (state)
            3'b001: begin  // state A
                if (r[3])
                    next = 3'b100;  // next state is D
                else if (r[2])
                    next = 3'b011;  // next state is C
                else if (r[1])
                    next = 3'b010;  // next state is B
                else
                    next = 3'b001;  // next state is A
            end
              
            3'b010: begin  // state B
                if (r[1])
                    next = 3'b010;  // next state is B
                else
                    next = 3'b001;  // next state is A
            end
                
            3'b011: begin  // state C
                if (r[2])
                    next = 3'b011;  // next state is C
                else
                    next = 3'b001;  // next state is A
            end
                
            3'b100: begin  // state D
                if (r[3])
                    next = 3'b100;  // next state is D
                else
                    next = 3'b001;  // next state is A
            end
        endcase
    end

    assign g[1] = (state == 3'b010) ? 1'b1 : 1'b0; // set g[1] high if current state is B
    assign g[2] = (state == 3'b011) ? 1'b1 : 1'b0; // set g[2] high if current state is C
    assign g[3] = (state == 3'b100) ? 1'b1 : 1'b0; // set g[3] high if current state is D
endmodule
