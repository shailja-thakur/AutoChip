module top_module (
    input clk,
    input reset,
    input w,
    output z
);

// Define states
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter D = 3;
parameter E = 4;
parameter F = 5;

// Define state register and next state
reg [2:0] state_reg, state_next;

// Define output register
reg z_reg;

// Define state transition and output logic
always @(posedge clk or posedge reset) begin
    if (reset)
        state_reg <= A;
    else
        state_reg <= state_next;
        
    case (state_reg)
        A: begin
            if (w)
                state_next = A;
            else
                state_next = B;
            z_reg = 0;
        end
        
        B: begin
            if (w)
                state_next = D;
            else
                state_next = C;
            z_reg = 0;
        end
        
        C: begin
            if (w)
                state_next = D;
            else
                state_next = E;
            z_reg = 0;
        end
        
        D: begin
            if (w)
                state_next = A;
            else
                state_next = F;
            z_reg = 0;
        end
        
        E: begin
            if (w)
                state_next = D;
            else
                state_next = E;
            z_reg = 1;
        end
        
        F: begin
            if (w)
                state_next = D;
            else
                state_next = C;
            z_reg = 1;
        end
    endcase
end

// Assign output
assign z = z_reg;

endmodule
