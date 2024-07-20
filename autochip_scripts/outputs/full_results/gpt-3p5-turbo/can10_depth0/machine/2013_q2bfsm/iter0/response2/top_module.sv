module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);
	
    // define states
    typedef enum logic [2:0] {
        A, B, S0, S1, S10, G1, G2, P0, P1
    } state_type;
	
    // declare current state and next state variables
    state_type current_state, next_state;
	
    // declare outputs
    assign f = (current_state == B) ? 1'b1 : 1'b0;
    assign g = (current_state == G1 || current_state == G2 || current_state == P1) ? 1'b1 : 1'b0;
	
    // synchronous always block for state update
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end
	
    // combinational always block for next state logic
    always_comb begin
        case (current_state)
            A: begin
                if (x) begin
                    next_state = B;
                end else begin
                    next_state = S0;
                end
            end
            B: next_state = S0;
            S0: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = S0;
                end
            end
            S1: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = S10;
                end
            end
            S10: begin
                if (x) begin
                    next_state = G1;
                end else begin
                    next_state = S0;
                end
            end
            G1: begin
                if (y) begin
                    next_state = P1;
                end else begin
                    next_state = G2;
                end
            end
            G2: begin
                if (y) begin
                    next_state = P1;
                end else begin
                    next_state = P0;
                end
            end
            P0, P1: next_state = current_state;
            default: next_state = A;
        endcase
    end
	
endmodule
