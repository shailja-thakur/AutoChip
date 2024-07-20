module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

// Define states
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Declare state register
reg [1:0] current_state, next_state;

// Declare output registers
reg [3:1] g_reg;

// State flip-flop
always @(posedge clk or negedge resetn) begin
    if (!resetn)
        current_state <= A;
    else
        current_state <= next_state;
end

// State transition logic
always @(current_state or r) begin
    case (current_state)
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
            if (g_reg[1] && r[1])
                next_state = B;
            else if (r[1])
                next_state = B;
            else if (r[2])
                next_state = A;
            else if (r[3])
                next_state = D;
            else
                next_state = A;
        end
        
        C: begin
            if (g_reg[2] && r[2])
                next_state = C;
            else if (r[1])
                next_state = B;
            else if (r[2])
                next_state = C;
            else if (r[3])
                next_state = D;
            else
                next_state = A;
        end
        
        D: begin
            if (r[1])
                next_state = B;
            else if (r[2])
                next_state = C;
            else if (r[3])
                next_state = D;
            else
                next_state = A;
        end
    endcase
end

// Output logic
always @(current_state) begin
    case (current_state)
        A: begin
            if (r[1] && !r[2] && !r[3])
                g_reg = 3'b001;
            else if (!r[1] && r[2] && !r[3])
                g_reg = 3'b010;
            else if (!r[1] && !r[2] && r[3])
                g_reg = 3'b100;
            else
                g_reg = 3'b000;
        end
        
        B: begin
            if (g_reg[1])
                g_reg = 3'b001;
            else if (r[1])
                g_reg = 3'b001;
            else if (r[2])
                g_reg = 3'b010;
            else if (r[3])
                g_reg = 3'b100;
            else
                g_reg = 3'b000;
        end
        
        C: begin
            if (g_reg[2])
                g_reg = 3'b010;
            else if (r[1])
                g_reg = 3'b001;
            else if (r[2])
                g_reg = 3'b010;
            else if (r[3])
                g_reg = 3'b100;
            else
                g_reg = 3'b000;
        end
        
        D: begin
            if (r[1])
                g_reg = 3'b001;
            else if (r[2])
                g_reg = 3'b010;
            else if (r[3])
                g_reg = 3'b100;
            else
                g_reg = 3'b000;
        end
    endcase
end

assign g = g_reg;

endmodule
