module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] present_state, next_state;

// State assignments
parameter [2:0] 
    S0 = 3'b000,
    S1 = 3'b001,
    S2 = 3'b010,
    S3 = 3'b011,
    S4 = 3'b100;

// Next state logic
always @(*) begin
    case (present_state)
        S0: begin
            if (x == 1'b0)
                next_state = S0;
            else
                next_state = S1;
        end
        S1: begin
            if (x == 1'b0)
                next_state = S1;
            else
                next_state = S4;
        end
        S2: begin
            if (x == 1'b0)
                next_state = S1;
            else
                next_state = S2;
        end
        S3: begin
            if (x == 1'b0)
                next_state = S1;
            else
                next_state = S2;
        end
        S4: begin
            if (x == 1'b0)
                next_state = S3;
            else
                next_state = S4;
        end
        default:
            next_state = S0;
    endcase
end

// Output logic
always @(*) begin
    case (present_state)
        S3, S4:
            z = 1'b1;
        default:
            z = 1'b0;
    endcase
end

// State register
always @(posedge clk or posedge reset) begin
    if (reset)
        present_state <= S0;
    else
        present_state <= next_state;
end

endmodule
