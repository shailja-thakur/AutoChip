module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state, next_state;

// State codes
localparam A = 3'b000;
localparam B = 3'b001;
localparam C = 3'b010;
localparam D = 3'b011;
localparam E = 3'b100;
localparam F = 3'b101;

// State transition table
always @(state, w) begin
    case(state)
    	A: begin
                if(w == 1'b1)
                    next_state = B;
                else
                    next_state = A;
            end
    	B: begin
                if(w == 1'b1)
                    next_state = C;
                else
                    next_state = D;
            end
    	C: begin
                if(w == 1'b1)
                    next_state = E;
                else
                    next_state = D;
            end
    	D: begin
                if(w == 1'b1)
                    next_state = F;
                else
                    next_state = A;
            end
        E: begin
                if(w == 1'b1)
                    next_state = E;
                else
                    next_state = D;
            end
        F: begin
                if(w == 1'b1)
                    next_state = C;
                else
                    next_state = D;
            end
        default: next_state = A;
    endcase
end

// State flip-flop
always @(posedge clk or posedge reset) begin
    if(reset)
        state <= A;
    else
        state <= next_state;
end

// FSM output
always @(state) begin
    case(state)
        E: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
