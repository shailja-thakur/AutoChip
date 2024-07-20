module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

    // Define all the states
    parameter A = 0;
    parameter B = 1;
    parameter S0 = 2;
    parameter S1 = 3;
    parameter S10 = 4;
    parameter G1 = 5;
    parameter G2 = 6;
    parameter P0 = 7;
    parameter P1 = 8;
    
    // Define the state register and next state logic
    reg [3:0] state_reg;
    reg [3:0] state_next;
    
    // Assign the initial state
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state_reg <= A;
        end else begin
            state_reg <= state_next;
        end
    end
    
    // Define the state transition logic
    always @(*) begin
        case (state_reg)
            A: begin
                if (x) begin
                    state_next = B;
                end else begin
                    state_next = S0;
                end
            end
            B: begin
                state_next = S0;
            end
            S0: begin
                if (x) begin
                    state_next = S1;
                end else begin
                    state_next = S0;
                end
            end
            S1: begin
                if (x) begin
                    state_next = S1;
                end else begin
                    state_next = S10;
                end
            end
            S10: begin
                if (x) begin
                    state_next = G1;
                end else begin
                    state_next = S0;
                end
            end
            G1: begin
                if (y) begin
                    state_next = P1;
                end else begin
                    state_next = G2;
                end
            end
            G2: begin
                if (y) begin
                    state_next = P1;
                end else begin
                    state_next = P0;
                end
            end
            P0: begin
                state_next = P0;
            end
            P1: begin
                state_next = P1;
            end
            default: begin
                // This should not be reached
                state_next = A;
            end
        endcase
    end
    
    // Define the outputs based on the current state
    assign f = (state_reg == B) ? 1'b1 : 1'b0;
    assign g = (state_reg == G1 || state_reg == G2 || state_reg == P1) ? 1'b1 : 1'b0;
    
endmodule
