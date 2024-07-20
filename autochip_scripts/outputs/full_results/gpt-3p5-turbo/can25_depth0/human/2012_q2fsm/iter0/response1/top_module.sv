module top_module (
    input clk,
    input reset,
    input w,
    output z
);

// Define state codes
parameter A = 3'b000;
parameter B = 3'b001;
parameter C = 3'b010;
parameter D = 3'b011;
parameter E = 3'b100;
parameter F = 3'b101;

// State register
reg [2:0] state_reg;
reg [2:0] next_state;

// Initialize state register
always @(posedge clk or posedge reset)
begin
    if (reset)
        state_reg <= A;
    else
        state_reg <= next_state;
end

// State transition logic
always @(state_reg or w)
begin
    case(state_reg)
        A: begin
            if (w)
                next_state = B;
            else
                next_state = A;
        end
        
        B: begin
            if (w)
                next_state = C;
            else
                next_state = D;
        end
        
        C: begin
            if (w)
                next_state = E;
            else
                next_state = D;
        end
        
        D: begin
            if (w)
                next_state = F;
            else
                next_state = A;
        end
        
        E: begin
            if (w)
                next_state = E;
            else
                next_state = D;
        end
        
        F: begin
            if (w)
                next_state = C;
            else
                next_state = D;
        end
    endcase
end

// Output logic
always @(state_reg)
begin
    case(state_reg)
        A, B, C, D: z = 1'b0;
        E, F: z = 1'b1;
    endcase
end

endmodule
