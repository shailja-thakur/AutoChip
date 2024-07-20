module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);
	
    typedef enum logic [3:0] {S, S1, S10} states;
    reg states state, next_state;
    
    always_ff @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            state <= S;
        end else begin
            state <= next_state;
        end
    end
    
    always_comb begin
        case (state)
            S: begin
                if (x == 0) begin
                    next_state = S;
                end else begin
                    next_state = S1;
                end
                z = 0;
            end
            S1: begin
                if (x == 0) begin
                    next_state = S10;
                end else begin
                    next_state = S1;
                end
                z = 0;
            end
            S10: begin
                if (x == 0) begin
                    next_state = S;
                end else begin
                    next_state = S1;
                end
                z = x;
            end
            default: begin
                next_state = S;
                z = 0;
            end
        endcase
    end
	
endmodule
