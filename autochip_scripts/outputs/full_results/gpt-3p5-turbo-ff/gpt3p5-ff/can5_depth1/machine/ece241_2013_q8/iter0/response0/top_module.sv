module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
    
    typedef enum logic [1:0] {
        S,       // state S
        S1,      // state S1
        S10      // state S10
    } state_t;

    state_t state, state_next;
    
    always_ff @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            state <= S;   // initialize state to S on reset
        end else begin
            state <= state_next;   // update state with state_next
        end
    end
    
    always_comb begin
        case (state)
            S: begin
                if (x == 0) begin
                    state_next = S;   // next state is S when x is 0 in state S
                end else if (x == 1) begin
                    state_next = S1;   // next state is S1 when x is 1 in state S
                end
                z = 0;   // output z is 0 when state is S
            end
            
            S1: begin
                if (x == 0) begin
                    state_next = S10;   // next state is S10 when x is 0 in state S1
                end else if (x == 1) begin
                    state_next = S1;   // next state is S1 when x is 1 in state S1
                end
                z = 0;   // output z is 0 when state is S1
            end
            
            S10: begin
                if (x == 0) begin
                    state_next = S;   // next state is S when x is 0 in state S10
                end else if (x == 1) begin
                    state_next = S1;   // next state is S1 when x is 1 in state S10
                end
                z = x;   // output z is x when state is S10
            end
        endcase
    end
endmodule
