module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    reg state, next_state;
    
    always @(posedge clk or posedge areset) begin
        if(areset) begin
            state <= 1'b0; // state B
        end
        else begin
            state <= next_state;
        end
    end
    
    always @(state, in) begin
        case(state)
            1'b0: begin // state B
                if(in) begin
                    next_state = 1'b0; // stay in state B
                end
                else begin
                    next_state = 1'b1; // transition to state A
                end
            end
            1'b1: begin // state A
                if(in) begin
                    next_state = 1'b1; // stay in state A
                end
                else begin
                    next_state = 1'b0; // transition to state B
                end
            end
            default: next_state = 1'b0;
        endcase
    end
    
    assign out = ~state;
    
endmodule
