module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

    reg [3:0] state, next_state;

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= 4'bA; // Initial state is A
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        f = (state == 4'bB); // f is assigned to 1 when the state is B.
        g = (state == 4'bG1) || (state == 4'bG2) || (state == 4'bP1); // g is assigned to 1 when the state is G1 or G2 or P1.
        case (state)
            4'bA:
                begin
                    if (x == 1'b1) begin
                        next_state = 4'bB; // From A state it goes to B
                    end else begin
                        next_state = 4'bA; // If x is 0, stay in A
                    end
                end
            4'bB:
                begin
                    next_state = 4'bS0; // From B state it goes to S0.
                end
            4'bS0:
                begin
                    if (x == 1'b1) begin
                        next_state = 4'bS1; // If x is 1 then it goes to S1.
                    end else begin
                        next_state = 4'bS0; // If x is 0 then it stays in S0 itself.
                    end
                end
            4'bS1:
                begin
                    if (x == 1'b1) begin
                        next_state = 4'bS1; // If x is 1 then it stays in S1.
                    end else begin
                        next_state = 4'bS10; // If x is 0 then it goes to S10.
                    end
                end
            4'bS10:
                begin
                    if (x == 1'b1) begin
                        next_state = 4'bG1; // If x is 1 then it goes to G1.
                    end else begin
                        next_state = 4'bS0; // If x is 0 then it goes to S0.
                    end
                end
            4'bG1:
                begin
                    if (y == 1'b1) begin
                        next_state = 4'bP1; // If y is 1 then it goes to P1.
                    end else begin
                        next_state = 4'bG2; // If y is 0 then it goes to G2.
                    end
                end
            4'bG2:
                begin
                    if (y == 1'b1) begin
                        next_state = 4'bP1; // If y is 1 then it goes to P1.
                    end else begin
                        next_state = 4'bP0; // If y is 0 then it goes to P0.
                    end
                end
            4'bP0:
                begin
                    next_state = 4'bP0; // It stays in P0.
                end
            4'bP1:
                begin
                    next_state = 4'bP1; // It stays in P1.
                end
            default:
                begin
                    next_state = 4'bA; // Default state is A.
                end
        endcase
    end

endmodule
