module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

// Define the states using symbolic names
localparam [2:0] 
    A = 3'b000, B = 3'b001, C = 3'b010, 
    D = 3'b011, E = 3'b100;

reg [2:0] state, next_state;

// State register
always @(posedge clk, posedge reset) begin
    if (reset)
        state <= A;
    else
        state <= next_state;
end

// Next state logic
always @(*) begin
    case (state)
        A: begin
            if (x)
                next_state = B;
            else
                next_state = A;
        end
        B: begin
            if (x)
                next_state = E;
            else
                next_state = B;
        end
        C: begin
            if (x)
                next_state = B;
            else
                next_state = C;
        end
        D: begin
            if (x)
                next_state = C;
            else
                next_state = B;
        end
        E: begin
            if (x)
                next_state = E;
            else
                next_state = D;
        end
        default:
            next_state = A;
    endcase
end

// Output logic
always @(*) begin
    case (state)
        D, E:
            z = 1'b1;
        default:
            z = 1'b0;
    endcase
end

endmodule
