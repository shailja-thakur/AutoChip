module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output [3:1] g
);

// Define the states
typedef enum logic [1:0] {
    A,
    B,
    C,
    D
} state_t;

// Define the state register
reg [1:0] state_reg;

// Define the next state
reg [1:0] next_state;

// Define the state outputs
reg [3:1] g_reg;

// State table
always_comb begin
    case (state_reg)
        A: begin
            if (r[1] && r[2] && r[3])
                next_state = A;
            else if (r[1] && !r[2] && !r[3])
                next_state = B;
            else if (!r[1] && r[2] && !r[3])
                next_state = C;
            else if (!r[1] && !r[2] && !r[3])
                next_state = D;
        end
        B: begin
            if (g_reg[1])
                next_state = B;
            else
                next_state = A;
        end
        C: begin
            if (g_reg[2])
                next_state = C;
            else
                next_state = A;
        end
        D: begin
            next_state = A;
        end
    endcase
end

// State flip-flops
always_ff @(posedge clk or negedge resetn) begin
    if (!resetn)
        state_reg <= A;
    else
        state_reg <= next_state;
end

// State outputs
always_comb begin
    case (state_reg)
        A: g_reg = {1'b0, 1'b0, 1'b0};
        B: g_reg = {1'b1, 1'b0, 1'b0};
        C: g_reg = {1'b0, 1'b1, 1'b0};
        D: g_reg = {1'b0, 1'b0, 1'b1};
    endcase
end

// Assign the state outputs to the module outputs
assign g = g_reg;

endmodule
