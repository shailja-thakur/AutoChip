module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// Define the states
localparam [2:0] S_A = 3'b000, S_B = 3'b001, S_C = 3'b010, S_D = 3'b011, S_E = 3'b100, S_F = 3'b101;

// Declare the state register
reg [2:0] state, next_state;

// State transition logic
always @(*) begin
    case (state)
        S_A: begin
            if (w) next_state = S_A;
            else   next_state = S_B;
        end
        S_B: begin
            if (w) next_state = S_D;
            else   next_state = S_C;
        end
        S_C: begin
            if (w) next_state = S_D;
            else   next_state = S_E;
        end
        S_D: begin
            if (w) next_state = S_A;
            else   next_state = S_F;
        end
        S_E: begin
            if (w) next_state = S_D;
            else   next_state = S_E;
        end
        S_F: begin
            if (w) next_state = S_D;
            else   next_state = S_C;
        end
        default: next_state = S_A;
    endcase
end

// Output logic
always @(*) begin
    case (state)
        S_E, S_F: z = 1'b1;
        default: z = 1'b0;
    endcase
end

// State register update
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= S_A;
    else
        state <= next_state;
end

endmodule
