module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// Define the states
localparam A = 4'b0000;
localparam B = 4'b0001;
localparam C = 4'b0010;
localparam D = 4'b0011;
localparam E = 4'b0100;
localparam F = 4'b0101;

// Register to hold the current state
reg [3:0] state, next_state;

// Next state logic
always @(*) begin
    case (state)
        A: begin
            if (w) next_state = A;
            else next_state = B;
        end
        B: begin
            if (w) next_state = D;
            else next_state = C;
        end
        C: begin
            if (w) next_state = D;
            else next_state = E;
        end
        D: begin
            if (w) next_state = A;
            else next_state = F;
        end
        E: begin
            if (w) next_state = D;
            else next_state = E;
        end
        F: begin
            if (w) next_state = D;
            else next_state = C;
        end
        default: next_state = A;
    endcase
end

// State register update
always @(posedge clk) begin
    if (reset) state <= A;
    else state <= next_state;
end

// Output logic
always @(*) begin
    case (state)
        E, F: z = 1;
        default: z = 0;
    endcase
end

endmodule
