module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// Define the states
localparam [2:0] A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

// Register to hold the current state
reg [2:0] state, next_state;

// Update the state on every clock cycle
always @(posedge clk) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

// Combinational logic to determine the next state
always @(*) begin
    case (state)
        A: begin
            if (w)
                next_state = A;
            else
                next_state = B;
        end
        B: begin
            if (w)
                next_state = D;
            else
                next_state = C;
        end
        C: begin
            if (w)
                next_state = D;
            else
                next_state = E;
        end
        D: begin
            if (w)
                next_state = A;
            else
                next_state = F;
        end
        E: begin
            if (w)
                next_state = D;
            else
                next_state = E;
        end
        F: begin
            if (w)
                next_state = D;
            else
                next_state = C;
        end
        default:
            next_state = A;
    endcase
end

// Combinational logic to set the output
always @(*) begin
    case (state)
        E, F: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
