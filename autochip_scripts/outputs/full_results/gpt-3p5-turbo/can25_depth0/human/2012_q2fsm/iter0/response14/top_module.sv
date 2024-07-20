module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
reg [2:0] next_state;

// State codes
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

// State table
//     Current State    w=0         w=1
//     -------------    ----        ----
// A       D             A           B
// B       D             D           C
// C       D             D           E
// D       A             F           D
// E       D             D           E
// F       D             D           C

always @(state, w) begin
    case (state)
        A: begin
            if (w == 1'b0)
                next_state = A;
            else
                next_state = B;
        end
        
        B: begin
            if (w == 1'b0)
                next_state = D;
            else
                next_state = C;
        end
        
        C: begin
            if (w == 1'b0)
                next_state = D;
            else
                next_state = E;
        end
        
        D: begin
            if (w == 1'b0)
                next_state = F;
            else
                next_state = A;
        end
        
        E: begin
            if (w == 1'b0)
                next_state = D;
            else
                next_state = E;
        end
        
        F: begin
            if (w == 1'b0)
                next_state = D;
            else
                next_state = C;
        end
    endcase
end

// State flip-flops
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

// Output assignment
always @(state) begin
    case (state)
        A, D: z = 1'b0;
        E, F: z = 1'b1;
        default: z = 1'bZ;
    endcase
end

endmodule
