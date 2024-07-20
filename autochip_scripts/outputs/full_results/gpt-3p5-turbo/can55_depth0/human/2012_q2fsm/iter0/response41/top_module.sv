module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// State codes
localparam A = 2'b00;
localparam B = 2'b01;
localparam C = 2'b10;
localparam D = 2'b11;
localparam E = 2'b100;
localparam F = 3'b101;

reg [1:0] state, next_state;

// State flip-flop
always @(posedge clk or posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

// State table
always @(state or w) begin
    case (state)
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
        default: next_state = A; // Default state
    endcase
end

// Output assignment
always @(state) begin
    case (state)
        E: z = 1;
        default: z = 0;
    endcase
end

endmodule
